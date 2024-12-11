//
//  HomeView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var articles: [Article]
    
    @AppStorage("showNewsTicker") private var showNewsTicker : Bool = true
    @AppStorage("newsTickerPosition") private var newsTickerPosition : String = "Top"
    
    var body: some View {
        VStack{
            if (showNewsTicker && newsTickerPosition == "Top"){
                NewsTickerView()
            }
            Spacer()
            if (articles.isEmpty) {
                VStack{
                    Image(systemName: "square.stack.3d.up.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Text("No articles are saved.")
                        .font(.title)
                }
            } else {
                List{
                    ForEach(articles){
                        article in
                        NavigationLink(destination: ArticleView(article: article)){
                            HStack{
                                AsyncImage(url: article.imageURL) { image in image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipped()
                                        .cornerRadius(20)
                                        .padding(.leading, 5)
                                } placeholder: {
                                    Image(systemName: "photo")
                                        .frame(width: 140, height: 140)
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
                            .cornerRadius(20)
                        }
                    }
                    .onDelete(perform: deleteArticle(_:))
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
            if (showNewsTicker && newsTickerPosition == "Bottom"){
                NewsTickerView()
            }
        }
    }
    
    
    /*
     Koden under er hentet fra:
     https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
     */
    func deleteArticle(_ indexSet : IndexSet){
        for i in indexSet {
            let article = articles[i]
            modelContext.delete(article)
        }
    }
    
}

