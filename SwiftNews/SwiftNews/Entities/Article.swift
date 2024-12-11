//
//  Article.swift
//  SwiftNews
//
//

import Foundation
import SwiftData

@Model
class Article: Hashable, Encodable, Decodable, Identifiable {
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(articleDescription, forKey: .articleDescription)
        try container.encode(publishingDate, forKey: .publishingDate)
        try container.encode(content, forKey: .content)
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription)
        imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        publishingDate = try container.decodeIfPresent(String.self, forKey: .publishingDate)
        content = try container.decodeIfPresent(String.self, forKey: .content)
    }
    
    init(author: String, title: String, articleDescription: String, imageURL: URL? = nil, publishingDate: String, content: String) {
        self.id = UUID()
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.imageURL = imageURL
        self.publishingDate = publishingDate
        self.content = content
    }
    
    var id : UUID
    var author : String?
    var title : String
    var articleDescription : String?
    var imageURL: URL?
    var publishingDate : String?
    var content : String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case title
        case articleDescription = "description"
        case imageURL = "urlToImage"
        case publishingDate = "publishedAt"
        case content
        
    }
}
