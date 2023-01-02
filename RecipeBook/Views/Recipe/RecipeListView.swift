//
//  RecipeListView.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject private var recipeListVM: RecipeListViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        
        VStack {
            List {
                ForEach(recipeListVM.recipeViewModels, id: \.id) { vm in
                    NavigationLink(destination: RecipeDetailView(recipeVM: vm), label: {
                        HStack {
                            Image(systemName: "text.book.closed").foregroundColor(.Accent).padding(.horizontal)
                            Text(vm.recipe.name).padding()
                        }
                    })
                }
                .onDelete(perform: recipeListVM.deleteAtOffsets)
            }
        }
        .sheet(isPresented: $showSheet) {
            CreateRecipeView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("ADD") {
                    showSheet = true
                }
            }
        }
    }
}
