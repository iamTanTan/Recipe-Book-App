//
//  GroceryListCollectionView.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import SwiftUI

struct GroceryListCollectionView: View {
    
    @EnvironmentObject private var groceryListCollectionVM: GroceryListCollectionViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        
        VStack {
            List {
                ForEach(groceryListCollectionVM.groceryListViewModels, id: \.id) { vm in
                    NavigationLink(destination: GroceryListDetailView(groceryListVM: vm), label: { Text(vm.groceryList.name).padding() }
                )}.onDelete(perform: groceryListCollectionVM.deleteFromList)
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("ADD") {
                    showSheet = true
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            CreateGroceryListView()
        }
    }
}
