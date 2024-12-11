//
//  SearchView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Search.date, order: .reverse) var searches: [Search]
    
    @State var searchString: String = ""
    @State var isLoading = false
    @FocusState var isFocused: Bool
    @State private var articles: [Article] = []
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Search articles",text: $searchString)
                        .padding(.horizontal, 30)
                        .focused($isFocused)
                        .onSubmit {
                            isLoading = true
                            Task {
                                await fetchArticles()
                                isLoading = false
                                isFocused = false
                                addSearch(searchString: searchString)
                                searchString = ""
                            }
                        }
                }
                if (isFocused && !searches.isEmpty){
                    ScrollView {
                        ForEach(searches){
                            search in
                            HStack{
                                Button(search.searchString){
                                    searchString = search.searchString
                                    Task{
                                        await fetchArticles()
                                        isFocused = false
                                    }
                                }
                                Spacer()
                            }.foregroundStyle(Color("textColor"))
                        }
                    }.frame(maxHeight: 100)
                        .padding(.top, 5)
                }
                
            }
            .padding()
            .background(Color("primaryColor"))
            .cornerRadius(20)
            Spacer()
            
            ScrollView{
                ForEach(articles){
                    article in
                    NavigationLink(destination: ArticleView(article: article)){
                        HStack{
                            AsyncImage(url: article.imageURL) { image in image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .clipped()
                                    .padding(.leading, 5)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            
                            VStack(alignment: .leading){
                                Text(article.title)
                                    .foregroundStyle(Color("textColor"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal)
                            
                        }
                        .frame(height: 150)
                        .background(Color("backgroundColor"))
                    }
                    
                    Divider()
                        .overlay(Color("secondaryColor"))
                }
            }
            
        }
    }
    
    func addSearch(searchString: String){
        modelContext.insert(Search(searchString: searchString))
        do {
            try modelContext.save()
        } catch {
            print("Error while saving search: \(error)")
        }
    }
    
    @MainActor
    func fetchArticles() async {
        guard let url = APIService().constructEverythingUrl(query: searchString) else {
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
