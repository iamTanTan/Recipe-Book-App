//
//  AddRecipeToBookView.swift
//  RecipeBook
//
//  Created by trackow on 11/8/22.
//

import SwiftUI

struct AddRecipeToBookView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeListVM: RecipeListViewModel
    
    @StateObject var bookVM: RecipeBookViewModel
    @State var selectionIndex: Int = 0
    @State var errorMsg: String? = nil
    
    var body: some View {
        
        VStack {
            if recipeListVM.recipeViewModels.count != 0 {
                Color(uiColor: .systemGroupedBackground)
                Form {
                    if errorMsg != nil {
                        Text(errorMsg!).foregroundColor(.red).padding()
                    }
                    Picker("Recipes", selection: $selectionIndex) {
                        ForEach(0..<recipeListVM.recipeViewModels.count, id: \.self) { idx in
                            Text(recipeListVM.recipeViewModels[idx].recipe.name)
                        }
                    }.pickerStyle(.inline)
                }
                Button {
                    if bookVM.recipeViewModels.map({ $0.id }).contains(recipeListVM.recipeViewModels[selectionIndex].id)
                    {
                        errorMsg = "You already added that recipe!"
                    }
                    else {
                        recipeListVM.addRecipeIdToBook(bookVM.book.id!, recipeListVM.recipeViewModels[selectionIndex].recipe.id!)
                        errorMsg = nil
                        dismiss()
                    }
                } label: {
                    Text("Add Recipe")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                Color(uiColor: .systemGroupedBackground)
                
                Button(role: .cancel) { dismiss() } label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.bordered).padding()
            }
            else {
                Spacer()
                Text("Oh no!").font(.title2).padding()
                
                Text("You haven't added any recipes to").font(.title3).padding(.horizontal)
                Text("'My Recipes' yet!").font(.title3).padding(.horizontal)
                
                Spacer()
                Button { dismiss() } label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.bordered).padding()
            }
        }.ignoresSafeArea()
    }
    
}
