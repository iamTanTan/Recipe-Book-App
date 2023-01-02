//
//  RecipeBookRow.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/6/22.
//

import SwiftUI

struct RecipeBookRow: View {
    @ObservedObject var bookVM: RecipeBookViewModel
    @State var isPresented: Bool = false
    @State var navigate: Bool = false
    
    var body: some View {
        HStack {
            Text(bookVM.book.name).font(.headline).padding()
            
            VStack {
                HStack {
                    Spacer()
                    Button(role: .destructive) {
                        isPresented = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                
                NavigationLink(isActive: $navigate, destination: {RecipeBookDetailView(vm: bookVM)}, label: {EmptyView()})
                HStack {
                    Spacer()
                    Button("View Recipes") {
                        navigate = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .confirmationDialog("Delete \(bookVM.book.name)?", isPresented: $isPresented, titleVisibility: .visible) {
                Button("Yes", role: .destructive) {
                    bookVM.delete(id: bookVM.book.id!)
                }
                
            }
            
        }
    }
}
