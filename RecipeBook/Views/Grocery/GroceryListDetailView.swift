//
//  GroceryListDetailView.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import SwiftUI

struct GroceryListDetailView: View {
    
    @ObservedObject var groceryListVM: GroceryListViewModel
    @State var isPresented: Bool = false
    @State var inputText: String = ""
    
    
    var body: some View {
        ZStack {
            Text(groceryListVM.groceryList.name)
            
            List {
                ForEach(groceryListVM.groceries.sorted(by: { $0.name < $1.name}), id: \.id) { grocery in
                    HStack {
                        CheckBoxView(checked: grocery.isBought, list_id: groceryListVM.groceryList.id!, currentGrocery: grocery)
                        Spacer()
                        Text("\(grocery.name)")
                        Spacer()
                        Text(String(format: "%.2f", grocery.amount))
                        Text(grocery.modifier ?? "")
                        
                    }
                }
                
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("ADD") {
                        isPresented = true
                    }
                }
            }.sheet(isPresented: $isPresented) {
                CreateGroceryView(vm: groceryListVM)
            }
        }.onAppear(perform: {groceryListVM.fetchGroceries()})
    }
    
    
    
    // todo binding
    struct CheckBoxView: View {
        
        @EnvironmentObject var groceryListCollectionVM: GroceryListCollectionViewModel
        @State var checked: Bool
        var list_id: String
        var currentGrocery: Grocery
        
        var body: some View {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    groceryListCollectionVM.updateGroceryStatus(grocery: currentGrocery)
                    checked.toggle()
                }
        }
    }
}
