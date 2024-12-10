//
//  Category.swift
//  SwiftNews
//
//

import Foundation
import SwiftData

@Model
class Category: Identifiable {
    var id: String
    var name: String
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}

extension Category {
    static var defaults: [Category] {
        [
            .init(name: "Business"),
            .init(name: "Entertainment"),
            .init(name: "General"),
            .init(name: "Health"),
            .init(name: "Science"),
            .init(name: "Sports"),
            .init(name: "Technology"),
        ]
    }
}
