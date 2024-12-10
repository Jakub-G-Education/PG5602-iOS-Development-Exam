//
//  Country+SwiftData.swift
//  SwiftNews
//
//

import Foundation
import SwiftData

extension Country {
    
    static func getAllCountries(withId id: String? = nil, inContext context: ModelContext) -> [Country] {
        
        var fetchDescriptor = FetchDescriptor<Country>()
        
        if let id {
            fetchDescriptor.predicate = #Predicate{ country in
                return country.id == id
            }
        }
        
        do{
            return try context.fetch(fetchDescriptor)
        } catch {
            fatalError("Error in fetch \(fetchDescriptor)")
        }
    }
    
    func storeInDatabase(context: ModelContext) {
        context.insert(Country(id: self.id, name: self.name, code: self.code))
        do {
            try context.save()
        } catch {
            print("Could not store country \(self), error: \(error)")
        }
    }
    
    func deleteFromDatabase(context: ModelContext) {
        // Fetch the country object by ID
        if let country = Country.getAllCountries(withId: self.id, inContext: context).first {
            context.delete(country)
            
            do {
                // Save changes after deletion
                try context.save()
            } catch {
                print("Could not delete country \(self), error: \(error)")
            }
        } else {
            print("Could not find country to delete: \(self)")
        }
    }
}
