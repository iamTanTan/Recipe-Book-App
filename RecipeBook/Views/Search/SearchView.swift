//
//  SearchView.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var searchVM: SearchViewModel
    @State var searchText: String = ""
    
    var body: some View {
        
        VStack {
            
            List {
                
                HStack {
                    TextField(text: $searchText, label: {Text("Search Recipes")}).padding().textFieldStyle(.roundedBorder)
                    Button(action: { searchVM.search(searchText)}, label: {Text("Search")}).buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.ultraThinMaterial)
               
                
                if let snippets = searchVM.recipeSnippets?.results {
                    ForEach(snippets, id: \.id) { snip in
                        NavigationLink(destination: SearchDetailView(id: snip.id, recipeName: snip.title), label: {
                            SearchRowView(snip: snip) 
                        })
                    }
                }
            }
        }
    }
}
