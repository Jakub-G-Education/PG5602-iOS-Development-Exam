//
//  ArticleView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct ArticleView: View {
    @Environment(\.modelContext) private var modelContext
    
    let article : Article
    
    var body: some View {
        
        ScrollView{
            AsyncImage(url: article.imageURL) { image in image
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 10)
            } placeholder: {
                ProgressView()
            }
            
            Text(article.title)
                .frame(maxWidth: .infinity ,alignment: .leading)
                .font(.title)
                .padding(.bottom, 10)
            
            Text(article.author ?? "")
                .frame(maxWidth: .infinity ,alignment: .trailing)
                .font(.caption2)
                .padding(.bottom, 10)
            
            Text(article.articleDescription ?? "")
                .frame(maxWidth: .infinity ,alignment: .leading)
                .font(.callout)
                .padding(.bottom, 10)
            
            
            
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{ addArticle() } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
        }
    }
    
    func addArticle(){
        modelContext.insert(Article(author: article.author ?? "", title: article.title, articleDescription: article.articleDescription ?? "", imageURL: article.imageURL ,publishingDate: article.publishingDate ?? "", content: article.content ?? ""))
        do {
            try modelContext.save()
        } catch {
            print("Error while saving article: \(error)")
        }
    }
    
}
