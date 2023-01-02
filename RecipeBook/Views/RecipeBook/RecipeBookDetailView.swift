//
//  RecipeBookDetailView.swift
//  RecipeMockup-SwiftUI
//
//  Created by trackow on 10/20/22.
//

// TODO: Rework fetch here. We are making a lot of api calls when we could be listening to a snapshot maybe... caching would be ideal

import SwiftUI

struct RecipeBookDetailView: View {
    
    @ObservedObject var vm: RecipeBookViewModel
    @State var show: Bool = false
    
    var body: some View {
        
        VStack {
            Text(vm.book.name).font(.title2)
            
            List {
                ForEach(vm.recipeViewModels, id: \.id) { vm in
                    NavigationLink(destination: RecipeDetailView(recipeVM: vm), label: {
                        HStack {
                            Image(systemName: "text.book.closed").foregroundColor(.Accent).padding(.horizontal)
                            Text(vm.recipe.name).padding()
                        }
                    })
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add recipe") {
                        show = true
                    }
                }
            }
            .sheet(isPresented: $show, onDismiss: {vm.fetchBookRecipes()}){
                AddRecipeToBookView(bookVM: vm)
            }
            .onAppear {vm.fetchBookRecipes() }
        }
        
    }
}
