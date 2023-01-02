//
//  RecipeBookListView.swift
//  RecipeMockup-SwiftUI
//
//  Created by trackow on 10/20/22.
//

import SwiftUI

struct RecipeBookListView: View {
    
    @EnvironmentObject var bookListVM: RecipeBookListViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @State var showSheet: Bool = false
    @State var showSignOutConfirm: Bool = false
    
    var body: some View {
        
        VStack {
            List {
                ForEach(bookListVM.recipeBookViewModels, id: \.id) { vm in
                    RecipeBookRow(bookVM: vm)
                }
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    authVM.signOut()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("ADD") {
                    showSheet = true
                }
            }
            
        }
        
        .sheet(isPresented: $showSheet) {
            CreateRecipeBookView()
        }
        
    }
}
