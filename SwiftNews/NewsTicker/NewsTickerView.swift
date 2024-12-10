//
//  NewsTickerView.swift
//  SwiftNews
//
//

import SwiftUI

struct NewsTickerView: View {
    
    @AppStorage("newsTickerFontSize") private var newsTickerFontSize : Int = 14
    @AppStorage("newsTickerTextColor") private var newsTickerTextColor : String = "textColor"
    
    @State private var articles: [Article] = []
    @State var offset: CGFloat = 0
    @State var totalNewsTickerWidth: CGFloat = 0
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 50) {
                ForEach(articles, id: \.title) { article in
                    Text(article.title)
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear{
                                        totalNewsTickerWidth += geometry.size.width + 50
                                    }
                            }
                        )
                }
            }
            .frame(height: 50)
            .foregroundColor(Color(newsTickerTextColor))
            .font(Font.system(size: CGFloat(newsTickerFontSize), weight: .medium))
            .offset(x: offset)
        }
        .disabled(true)
        .background(Color("primaryColor"))
        .onChange(of: articles) {
            totalNewsTickerWidth = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: Double(articles.count * 5)).repeatForever(autoreverses: false)) {
                    offset = -totalNewsTickerWidth
                }
            }
        }
        .task {
            await fetchTopHeadlines()
        }
        
    }
    
    @MainActor
    func fetchTopHeadlines() async {
        guard let url = APIService().constructTopNewsUrl() else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            let articles = try JSONDecoder().decode(APIService.APIResponse.self, from: data)
            
            self.articles = articles.articles
            
        } catch {
            print(error)
        }
    }
}
