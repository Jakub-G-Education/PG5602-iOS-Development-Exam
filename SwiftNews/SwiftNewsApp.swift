//
//  SwiftNewsApp.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

@main
struct SwiftNewsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Country.self,
            Category.self,
            Search.self,
            Article.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
    /* Koden for å fylle database ved første oppstart er hentet fra:
     https://www.youtube.com/watch?v=2Y9dYbFNUaY&ab_channel=tundsdev
     */
        
        do {
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
            let fetchDescriptorCountry = FetchDescriptor<Country>()
            let countryContainer = try container.mainContext.fetch(fetchDescriptorCountry)
            if (countryContainer.isEmpty){
                Country.defaults.forEach{ container.mainContext.insert($0)}
                try container.mainContext.save()
            }
            let fetchDescriptorCategory = FetchDescriptor<Category>()
            let categoryContainer = try container.mainContext.fetch(fetchDescriptorCategory)
            if (categoryContainer.isEmpty){
                Category.defaults.forEach{ container.mainContext.insert($0)}
                try container.mainContext.save()
            }
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
