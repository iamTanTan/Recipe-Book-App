//
//  CreateRecipeBookView.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import SwiftUI

struct CreateRecipeBookView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeBookListVM: RecipeBookListViewModel
    @EnvironmentObject var authVM: AuthViewModel
    
    @State var name: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Color(uiColor: .systemGroupedBackground)
            Form {
                TextField("Recipe Book Name", text: $name)
            }
            Button {
                let book = RecipeBooklet(name: name, recipes: [Recipe](), recipeIds: [], author: authVM.user?.uid ?? "no uid", updatedOn: Date())
                recipeBookListVM.add(recipeBook: book)
                dismiss()
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
