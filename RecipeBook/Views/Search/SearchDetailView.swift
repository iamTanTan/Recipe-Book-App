//
//  SearchDetailView.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/13/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchDetailView: View {
    
    @EnvironmentObject var vm: SearchViewModel
    @EnvironmentObject var recipeListVM: RecipeListViewModel
    @State var showGenerateConfirmation: Bool = false
    
    let id: Int
    let recipeName: String
    @State var recipe: Recipe? = nil
    
    
    var body: some View {
        
        VStack {
            
            if vm.currentRecipe != nil, vm.currentRecipe!.name == recipeName {
                
                List {
                    Section(header: Text("Recipe Name").bold()) {
                        HStack{
                            Spacer()
                            Text(vm.currentRecipe!.name.uppercased()).bold()
                            Spacer()
                        }
                    }
                    
                    WebImage(url: URL(string: vm.currentRecipe?.imageUrl ?? "https://via.placeholder.com/150"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .transition(.fade(duration: 0.5))
                        .frame(alignment: .center)
                    
                    Section(header: Text("Cooking Time").bold()) {
                        Text("Total time: \(vm.currentRecipe!.totalTime)")
                        HStack {
                            Text("Prep time: \(vm.currentRecipe!.prepTime)")
                            Spacer()
                            Text("Cook time: \(vm.currentRecipe!.cookTime)")
                        }
                    }.listStyle(GroupedListStyle())
                    
                    Section(header: Text("Ingredients").bold()) {
                        
                        ForEach(vm.currentRecipe!.ingredients, id: \.id) { ingredient in
                            
                            HStack {
                                Text("\(String(format: "%.2f", ingredient.amount))")
                                Text(ingredient.unit ?? "")
                                Text(ingredient.name)
                            }
                        }
                        
                    }.listStyle(GroupedListStyle())
                    
                    
                    Section(header: Text("Steps").bold()) {
                        if vm.currentRecipe!.steps.count == 1 {
                            Text(vm.currentRecipe!.steps.first!)
                        }
                        else
                        {
                            ForEach(vm.currentRecipe!.steps.indices, id: \.self) { idx in
                                Text("\(idx + 1). \(vm.currentRecipe!.steps[idx])" )
                            }
                        }
                    }.listStyle(GroupedListStyle())
                    
                    Section(header: Text("Details").bold()) {
                        HStack {
                            Text("Visible to public: ")
                            Text("\(vm.currentRecipe!.isPublic ? "Yes" : "No")").foregroundColor(vm.currentRecipe!.isPublic ? .green : .red)
                        }
                        
                        if let url = vm.currentRecipe?.recipeUrl {
                            Link("Original Recipe Source", destination: URL(string: url)!).foregroundColor(.blue)
                        }
                        
                        Text("Created on: \(vm.currentRecipe!.createdOnString)")
                        Text("Last Updated on: \(vm.currentRecipe!.updatedOnString)")
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add to My Recipes") {
                            showGenerateConfirmation = true
                        }
                    }
                }.confirmationDialog(Text("Add to Your Recipes: \(vm.currentRecipe!.name)?"), isPresented: $showGenerateConfirmation, titleVisibility: .visible) {
                    Button("Yes") {
                        recipeListVM.add(recipe: vm.currentRecipe!)
                    }
                }
            }
            else {
                Text("Loading")
            }
            
        }     .onAppear(perform: {vm.getRecipeInfo(id)})
    }
}
