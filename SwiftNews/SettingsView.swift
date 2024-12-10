//
//  SettingsView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    //Second apiKey: a72b2fd866f842359740bcf4d4487631
    
    @AppStorage("apiKey") private var apiKey : String = "fa0e44e5fb58435bbfb948441e3817d7"
    @AppStorage("useDarkMode") private var useDarkMode : Bool = false
    @AppStorage("showNewsTicker") private var showNewsTicker : Bool = true
    @AppStorage("newsTickerPosition") private var newsTickerPosition : String = "Top"
    @AppStorage("newsTickerFontSize") private var newsTickerFontSize : Int = 14
    @AppStorage("newsTickerTextColor") private var newsTickerTextColor : String = "textColor"
    @AppStorage("newsTickerCountry") private var newsTickerCountry : String = "us"
    @AppStorage("newsTickerCategory") private var newsTickerCategory : String = "Technology"
    
    
    @State var showApiKey = false
    @State var isShowingSheet = false
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Country.name) var countries: [Country]
    @Query var categories: [Category]
    
    
    var body: some View {
        
        Form{
            
            Section(header: Text("Api")){
                if (!showApiKey){
                    SecureField("Enter API Key", text: $apiKey)
                } else {
                    TextField("Enter API Key", text: $apiKey)
                }
                Button{showApiKey.toggle()} label: {
                    showApiKey ? Text("Hide API key") : Text("Show API key")
                }
            }
            
            Section(header: Text("Colors")){
                
                Toggle(isOn: $useDarkMode){
                    Text("Dark Mode")
                }
            }
            
            Section(header: Text("News Ticker")){
                
                Toggle(isOn: $showNewsTicker){
                    Text("Active")
                }
                
                if(showNewsTicker){
                    
                    Picker("Place", selection: $newsTickerPosition){
                        Text("Top").tag("Top")
                        Text("Bottom").tag("Bottom")
                    }
                    
                    Picker("Text Size", selection: $newsTickerFontSize){
                        Text("Small").tag(10)
                        Text("Regular").tag(14)
                        Text("Big").tag(18)
                    }
                    
                    Picker("Text Color", selection: $newsTickerTextColor){
                        Text("Default").tag("textColor")
                        Text("Blue").tag("accentColor")
                        Text("Pink").tag("secondaryColor")
                    }
                    
                    Picker("News Country", selection: $newsTickerCountry) {
                        Text("Worldwide").tag("")
                        ForEach(countries) { country in
                            Text(country.name).tag(country.code)
                        }
                    }
                    
                    Picker("News Category", selection: $newsTickerCategory) {
                        Text("All").tag("")
                        ForEach(categories) { category in
                            Text(category.name).tag(category.name)
                        }
                    }
                }
            }
            
            Section{
                
                NavigationLink{
                    CountriesSettingsView()
                        .navigationTitle(Text("Manage Countries"))
                } label: {
                    Text("Manage Countries")
                }
                
                NavigationLink{
                    CategorySettingsView()
                        .navigationTitle(Text("Manage Categories"))
                } label: {
                    Text("Manage Categories")
                }
            }
        }
    }
}

