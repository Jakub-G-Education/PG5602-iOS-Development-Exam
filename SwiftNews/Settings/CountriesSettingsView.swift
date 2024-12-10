//
//  CountriesSettingsView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct CountriesSettingsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Country.name) var countries: [Country]
    
    @AppStorage("newsTickerCountry") private var newsTickerCountry : String = "us"
    
    @State private var countryName : String = ""
    @State private var countryCode : String = ""
    @State private var addStatus : String = ""
    
    var body: some View {
        List{
            
            Section(header: Text("Add Country")){
                VStack{
                    HStack{
                        Text("Country name:")
                        TextField("", text: $countryName)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.words)
                    }
                    HStack{
                        Text("Country code:")
                        TextField("", text: $countryCode)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                    }
                    Text(addStatus)
                        .foregroundColor(.red)
                        .padding(.vertical, 5)
                    
                    HStack{
                        Button(action: {addCountry(name: countryName, code: countryCode)}){
                            Text("Add")
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color("primaryColor")).foregroundColor(Color("textColor"))
                        .containerShape(.capsule)
                    }
                }
            }.contentMargins(.bottom, 30).padding(.vertical, 10)
            
            Section(header: Text("Countries")){
                ForEach(countries) { country in
                    HStack{
                        AsyncImage(url: country.flagURL)
                        { image in image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 30)
                        Text(country.name)
                        Spacer()
                        Image(systemName: "arrow.left")
                        Image(systemName: "trash")
                            .foregroundStyle(Color("secondaryColor"))
                    }
                    .padding(.vertical, 10)
                }
                .onDelete(perform: deleteCountry(_:))
            }
        }.listStyle(.insetGrouped)
    }
    
    
    func addCountry(name: String, code: String){
        if(countryName.isEmpty || countryCode.isEmpty){
            addStatus = "You need to fill out both fields"
            return
        }
        modelContext.insert(Country(name: name, code: code))
        do {
            try modelContext.save()
            countryCode = ""
            countryName = ""
        } catch {
            print("Error while saving country: \(error)")
        }
    }
    
    /*
     Koden under er hentet fra:
     https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
     */
    func deleteCountry(_ indexSet : IndexSet){
        for i in indexSet {
            let country = countries[i]
            modelContext.delete(country)
            
            if (country.code == newsTickerCountry) {
                newsTickerCountry = ""
            }
        }
    }
}
