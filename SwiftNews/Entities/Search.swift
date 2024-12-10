//
//  Search.swift
//  SwiftNews
//
//

import Foundation
import SwiftData

@Model
class Search: Identifiable {
    var id: String
    var searchString: String
    var date: Date
    
    init(id: String = UUID().uuidString, searchString: String) {
        self.id = id
        self.searchString = searchString
        self.date = Date()
    }
}
