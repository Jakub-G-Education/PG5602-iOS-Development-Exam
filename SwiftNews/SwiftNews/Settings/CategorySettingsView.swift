//
//  CategorySettingsView.swift
//  SwiftNews
//
//

import SwiftUI
import SwiftData

struct CategorySettingsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var categories: [Category]
    
    @AppStorage("newsTickerCategory") private var newsTickerCategory : String = "Technology"
    
    @State private var categoryName : String = ""
    @State private var addStatus : String = ""
    
    var body: some View {
        List{
            
            Section(header: Text("Add Category")){
                VStack{
                    HStack{
                        Text("Category name:")
                        TextField("", text: $categoryName)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.words)
                    }
                    Text(addStatus)
                        .foregroundColor(.red)
                        .padding(.vertical, 5)
                    
                    HStack{
                        Button(action: {addCategory(name: categoryName)}){
                            Text("Add")
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color("primaryColor")).foregroundColor(Color("textColor"))
                        .containerShape(.capsule)
                    }
                }
            }.contentMargins(.bottom, 30).padding(.vertical, 10)
            
            Section(header: Text("Categories")){
                ForEach(categories) { category in
                    HStack{
                        Text(category.name)
                        Spacer()
                        Image(systemName: "arrow.left")
                        Image(systemName: "trash")
                            .foregroundStyle(Color("secondaryColor"))
                    }
                    .padding(.vertical, 10)
                }
                .onDelete(perform: deleteCategory(_:))
            }
        }.listStyle(.insetGrouped)
    }
    
    
    func addCategory(name: String){
        if(categoryName.isEmpty){
            addStatus = "You need to fill out category name"
            return
        }
        modelContext.insert(Category(name: name))
        do {
            try modelContext.save()
            categoryName = ""
        } catch {
            print("Error while saving category: \(error)")
        }
    }
    
    /*
     Koden under er hentet fra:
     https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
     */
    func deleteCategory(_ indexSet : IndexSet){
        for i in indexSet {
            let category = categories[i]
            modelContext.delete(category)
            
            if (category.name == newsTickerCategory) {
                newsTickerCategory = ""
            }
        }
    }
}
