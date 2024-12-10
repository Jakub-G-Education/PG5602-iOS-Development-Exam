//
//  ContentView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var hasSeenSplash = false;
    
    @AppStorage("useDarkMode") private var useDarkMode : Bool = false;
    
    var body: some View {
        if hasSeenSplash {
            
            TabView {
                NavigationStack{
                    HomeView()
                }.tabItem {
                        Label("My Articles", systemImage: "swift")
                    }
                NavigationStack{
                    SearchView()
                }.tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                }
                NavigationStack{
                    SettingsView()
                }.tabItem{
                    Label("Settings", systemImage: "gear")
                }
            }
            .preferredColorScheme(useDarkMode ? .dark : .light)
            
        } else {
            SplashView()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation{
                            hasSeenSplash = true
                        }
                    }
                }
        }
    }
}
