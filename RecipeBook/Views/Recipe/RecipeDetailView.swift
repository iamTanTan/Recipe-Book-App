//
//  RecipeDetailView.swift
//  RecipeMockup-SwiftUI
//
//  Created by trackow on 10/20/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeDetailView: View {
    
    @StateObject var recipeVM: RecipeViewModel
    @EnvironmentObject var groceryListCollectionVM: GroceryListCollectionViewModel
    @State var showGenerateConfirmation: Bool = false
    
    var body: some View {
        
        List {
            Section(header: Text("Recipe Name").bold()) {
                HStack{
                    Spacer()
                    Text(recipeVM.recipe.name.uppercased()).bold()
                    Spacer()
                }
            }
            
            if let imageURL = recipeVM.recipe.imageUrl {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.fade(duration: 0.5))
                    .frame(alignment: .center)
            }
            
            Section(header: Text("Cooking Time").bold()) {
                Text("Total time: \(recipeVM.recipe.totalTime)")
                HStack {
                    Text("Prep time: \(recipeVM.recipe.prepTime)")
                    Spacer()
                    Text("Cook time: \(recipeVM.recipe.cookTime)")
                }
            }.listStyle(GroupedListStyle())
            
            Section(header: Text("Ingredients").bold()) {
                
                ForEach(recipeVM.recipe.ingredients, id: \.id) { ingredient in
                    
                    HStack {
                        Text("\(String(format: "%.2f", ingredient.amount))")
                        Text(ingredient.unit ?? "")
                        Text(ingredient.name)
                    }
                }
                
            }.listStyle(GroupedListStyle())
            
            
            Section(header: Text("Steps").bold()) {
                if recipeVM.recipe.steps.count == 1 {
                    Text(recipeVM.recipe.steps.first!)
                }
                else
                {
                    
                    ForEach(recipeVM.recipe.steps.indices, id: \.self) { idx in
                        
                        HStack {
                            Text("\(idx + 1). \(self.recipeVM.recipe.steps[idx])" )}
                    }
                }
            }.listStyle(GroupedListStyle())
            
            Section(header: Text("Details").bold()) {
                HStack {
                    Text("Visible to public: ")
                    Text("\(recipeVM.recipe.isPublic ? "Yes" : "No")").foregroundColor(recipeVM.recipe.isPublic ? .green : .red)
                }
                
                if let url = recipeVM.recipe.recipeUrl {
                    Link("Original Recipe Source", destination: URL(string: url)!).foregroundColor(.blue)
                }
                
                Text("Created on: \(recipeVM.recipe.createdOnString)")
                Text("Last Updated on: \(recipeVM.recipe.updatedOnString)")
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate Grocery List") {
                    
                    
                    showGenerateConfirmation = true
                    
                }
            }
        }.confirmationDialog(Text("Create a grocery List from recipe: \(recipeVM.recipe.name)?"), isPresented: $showGenerateConfirmation, titleVisibility: .visible) {
            Button("Yes") {
                
                let generatedList = GroceryList(name: "\(recipeVM.recipe.name) - Generated List", createdOn: Date(), updatedOn: Date())
                let genGroceries: [Grocery] = recipeVM.recipe.ingredients.map { Grocery(list_id: "should be overwritten", name: $0.name, amount: $0.amount, modifier: $0.unit) }
                
                groceryListCollectionVM.generateGroceryList(generatedList, genGroceries)
            }
        }
        
        
    }
}
