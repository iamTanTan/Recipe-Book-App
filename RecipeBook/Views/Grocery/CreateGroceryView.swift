//
//  CreateGroceryView.swift
//  RecipeBook
//
//  Created by trackow on 11/10/22.
//

import SwiftUI

struct CreateGroceryView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: GroceryListViewModel
    
    @State var name: String = ""
    @State var amount: String = ""
    @State var errorText: String? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Color(uiColor: .systemGroupedBackground)
            Form {
                if errorText != nil {
                    Text(errorText!).foregroundColor(.red).padding()
                }
                TextField("Name", text: $name, prompt: Text("ingredient name"))
                TextField("Amount", text: $amount, prompt: Text("amount")) .keyboardType(.decimalPad)
            }
            Button {
                if let amountD = Double(amount), name != "" {
                    vm.addToList(Grocery(list_id: vm.groceryList.id!,name: name, isBought: false, amount: amountD))
                    name = ""
                    amount = ""
                    errorText = nil
                    dismiss()
                }
                else {
                    if name == "" {
                        errorText = "Please add a name for the Grocery!"
                    } else {
                        errorText = "Amount needs to be a number!"
                    }
                }
            } label: {
                Text("Add Ingredient")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .padding()
            Color(uiColor: .systemGroupedBackground)
            Button { dismiss() } label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.bordered).padding()
        }  .ignoresSafeArea()
    }
}
