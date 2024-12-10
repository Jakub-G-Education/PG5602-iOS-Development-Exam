//
//  APIService.swift
//  SwiftNews
//
//

import Foundation
import SwiftUI
import SwiftData

class APIService {
    
    @AppStorage("newsTickerCountry") private var newsTickerCountry : String = "us"
    @AppStorage("newsTickerCategory") private var newsTickerCategory : String = "Technology"
    @AppStorage("apiKey") private var apiKey : String = "fa0e44e5fb58435bbfb948441e3817d7"
    
    struct APIResponse: Decodable {
        let articles: [Article]
    }
    
    func constructTopNewsUrl() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [
            URLQueryItem(name: "country", value: newsTickerCountry.isEmpty ? nil : newsTickerCountry.lowercased()),
            URLQueryItem(name: "category", value: newsTickerCategory.isEmpty ? nil : newsTickerCategory.lowercased()),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        let url = components.url
        print(components.url?.absoluteString ?? "error")
        return url
    }
    
    func constructEverythingUrl(query: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "q", value: query.isEmpty ? nil : query.lowercased()),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        let url = components.url
        print(components.url?.absoluteString ?? "error")
        return url
    }
    
}

