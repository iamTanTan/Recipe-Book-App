//
//  CreateGroceryListView.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import SwiftUI

struct CreateGroceryListView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var groceryListCollectionVM: GroceryListCollectionViewModel
    
    @State var listName: String = ""
    @State var errorText: String? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Color(uiColor: .systemGroupedBackground)
            Form {
                if errorText != nil {
                    Text(errorText!).foregroundColor(.red).padding()
                }
                TextField("Grocery List Name", text: $listName)            }
            Button {
                if listName != "" {
                    groceryListCollectionVM.add(GroceryList(name: listName, updatedOn: Date()))
                    errorText = nil
                    dismiss()
                }
                else {
                    errorText = "Please enter a name for the List!"
                }
            } label: {
                Text("Create")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            Color(uiColor: .systemGroupedBackground)
            
            Button(role: .cancel) {
                dismiss()
            } label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.bordered).padding()
        }.ignoresSafeArea()
    }
}
