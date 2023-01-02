//
//  CreateRecipeView.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import SwiftUI

struct CreateRecipeView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeListVM: RecipeListViewModel
    @State var recipeName: String = ""
    @State var ingredient: String = ""
    @State var steps: [String] = [String]()
    @State var step: String = ""
    @State var prepTime: Int = 0
    @State var cookTime: Int = 0
    @State var isPublic: Bool = false
    
    // ingredient input variables
    @State var ingredientName: String = ""
    @State var ingredientAmount: String = ""
    @State var ingredientUnit: String = ""
    @State var ingredientModifier: String = ""
    @State var ingredientInputError: String? = nil
    
    @State var ingredientList: [Ingredient] = [Ingredient]()
    
    var body: some View {
        
        VStack {
            // Cancel Button
            Button(role: .cancel) {
                dismiss()
            } label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
            }  .buttonStyle(.bordered)
            
            Form {
                // Recipe Name input
                Section(header: Text("Recipe Name")) {
                    TextField("Recipe Name", text: $recipeName)
                }.font(.headline)
                
                // Cook Time
                Section(header: Text("Prep time")){
                    Picker("Time prepping", selection: $prepTime) {
                        ForEach(0..<481) {
                            if $0 > 59 {
                                Text("\($0 / 60) hour(s) and \($0 % 60) minutes")
                            } else if $0 > 1 {
                                Text("\($0) minutes")
                            } else {
                                Text("\($0) minute")
                            }
                            
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                .font(.headline)
                
                Section(header: Text("Cook time")){
                    Picker("Time cooking", selection: $cookTime) {
                        ForEach(0..<481) {
                            if $0 > 59 {
                                Text("\($0 / 60) hour(s) and \($0 % 60) minutes")
                            } else if $0 > 1 {
                                Text("\($0) minutes")
                            } else {
                                Text("\($0) minute")
                            }
                            
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                .font(.headline)
                
                // Ingredient input and add button
                IngredientInput(name: $ingredientName, amount: $ingredientAmount, modifier: $ingredientModifier, unit: $ingredientUnit, ingredientInputError: $ingredientInputError, ingredients: $ingredientList)
                
                Button {
                    if let amountD = Double(ingredientAmount) {
                        ingredientList.append(Ingredient(name: ingredientName, amount: amountD, modifier: ingredientModifier, unit: ingredientUnit))
                        clearIngredientFields()
                    }
                    else {
                        ingredientInputError = "Make sure name and amount are filled (amount needs to be a number!)"
                    }
                } label: {
                    Text("Add Ingredient")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                
                // Recipe Steps
                Section(header: Text("Steps")) {
                    List {
                        ForEach(steps.indices, id:\.self) { idx in
                            Text("\(idx + 1). \(steps[idx])")
                            
                        }.onDelete {
                            (indexSet) in
                            self.steps.remove(atOffsets: indexSet)
                        }
                    }
                    
                    
                    TextField("Recipe Steps", text: $step)
                    Button {
                        steps.append(step)
                        step = ""
                    } label: {
                        Text("Add Step")
                            .frame(maxWidth: .infinity)
                    }  .buttonStyle(.borderedProminent)
                    
                }.font(.headline)
                
//                // Public Status
//                Section(header: Text("Make Recipe Public?")) {
//                    Toggle("Public", isOn: $isPublic)
//                    
//                }.font(.headline)
                
                // Add Button
                Button {
                    recipeListVM.add(recipe: Recipe(name: recipeName, category: "unknown", author: "", prepTime: prepTime, cookTime: cookTime, ingredients: ingredientList, steps: steps, isPublic: isPublic, createdOn: Date(), updatedOn: Date()))
                    
                    dismiss()
                } label: {
                    Text("Create Recipe")
                        .frame(maxWidth: .infinity)
                }  .buttonStyle(.borderedProminent)
            }
        }
    }
    
    func clearIngredientFields() {
        ingredientName = ""
        ingredientAmount = ""
        ingredientUnit = ""
        ingredientModifier = ""
        ingredientInputError = nil
    }
    
}
