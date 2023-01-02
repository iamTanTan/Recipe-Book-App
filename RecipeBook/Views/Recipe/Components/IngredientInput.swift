//
//  IngredientInput.swift
//  RecipeBook
//
//  Created by trackow on 11/8/22.
//

import Foundation
import SwiftUI

struct IngredientInput: View {
    
    @Binding var name: String
    @Binding var amount: String
    @Binding var modifier: String
    @Binding var unit: String
    @Binding var ingredientInputError: String?
    @Binding var ingredients: [Ingredient]
    
    var body: some View {
        Section("Ingredients") {
            List(ingredients, id: \.name) { ingredient in
                Text("Ingredient: \(String(format: "%.2f",ingredient.amount)) \(ingredient.unit ?? "") of \(ingredient.name) \(ingredient.modifier ?? "")")
            }
            
            if ingredientInputError != nil {
                Text(ingredientInputError!).foregroundColor(.red)
            }
            
            TextField("Name", text: $name, prompt: Text("ingredient name"))
            HStack {
                TextField("Amount", text: $amount, prompt: Text("amount")) .keyboardType(.decimalPad)
                TextField("Unit (cups, oz, grams, etc.)", text: $unit, prompt: Text("unit"))
            }
            TextField("Modifier (cubed, shredded, etc.)", text: $modifier, prompt: Text("modifier"))
        }.font(.headline)
    }
}
