//
//  Country.swift
//  SwiftNews
//
//

import Foundation
import SwiftData

@Model
class Country: Identifiable {
    var id: String
    var name: String
    var code: String
    
    init(id: String = UUID().uuidString, name: String, code: String) {
        self.id = id
        self.name = name
        self.code = code
    }
    
    var flagURL: URL? {
        return URL(string: "https://flagsapi.com/\(code.uppercased())/flat/64.png")
    }
}

extension Country {
    static var defaults: [Country] {
        [
            .init(name: "United Arab Emirates", code: "ae"),
            .init(name: "Argentina", code: "ar"),
            .init(name: "Austria", code: "at"),
            .init(name: "Australia", code: "au"),
            .init(name: "Belgium", code: "be"),
            .init(name: "Bulgaria", code: "bg"),
            .init(name: "Brazil", code: "br"),
            .init(name: "Canada", code: "ca"),
            .init(name: "Switzerland", code: "ch"),
            .init(name: "China", code: "cn"),
            .init(name: "Colombia", code: "co"),
            .init(name: "Czech Republic", code: "cz"),
            .init(name: "Germany", code: "de"),
            .init(name: "Egypt", code: "eg"),
            .init(name: "France", code: "fr"),
            .init(name: "United Kingdom", code: "gb"),
            .init(name: "Greece", code: "gr"),
            .init(name: "Hong Kong", code: "hk"),
            .init(name: "Hungary", code: "hu"),
            .init(name: "Indonesia", code: "id"),
            .init(name: "Ireland", code: "ie"),
            .init(name: "Israel", code: "il"),
            .init(name: "India", code: "in"),
            .init(name: "Italy", code: "it"),
            .init(name: "Japan", code: "jp"),
            .init(name: "South Korea", code: "kr"),
            .init(name: "Lithuania", code: "lt"),
            .init(name: "Latvia", code: "lv"),
            .init(name: "Morocco", code: "ma"),
            .init(name: "Mexico", code: "mx"),
            .init(name: "Malaysia", code: "my"),
            .init(name: "Nigeria", code: "ng"),
            .init(name: "Netherlands", code: "nl"),
            .init(name: "Norway", code: "no"),
            .init(name: "New Zealand", code: "nz"),
            .init(name: "Philippines", code: "ph"),
            .init(name: "Poland", code: "pl"),
            .init(name: "Portugal", code: "pt"),
            .init(name: "Romania", code: "ro"),
            .init(name: "Serbia", code: "rs"),
            .init(name: "Russia", code: "ru"),
            .init(name: "Saudi Arabia", code: "sa"),
            .init(name: "Sweden", code: "se"),
            .init(name: "Singapore", code: "sg"),
            .init(name: "Slovakia", code: "sk"),
            .init(name: "Thailand", code: "th"),
            .init(name: "Turkey", code: "tr"),
            .init(name: "Taiwan", code: "tw"),
            .init(name: "Ukraine", code: "ua"),
            .init(name: "United States", code: "us"),
            .init(name: "Venezuela", code: "ve"),
            .init(name: "South Africa", code: "za"),
        ]
    }
}
