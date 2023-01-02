//
//  GroceryListViewModel.swift
//  RecipeBook
//
//  Created by trackow on 11/8/22.
//

import Combine

final class GroceryListViewModel: ObservableObject, Identifiable {
    
    @Published var groceryList: GroceryList
    @Published var groceries: [Grocery] = [Grocery]()
    private let groceryListRepository = GroceryListRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    
    init(_ list: GroceryList) {
        self.groceryList = list
        
        $groceryList.compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        groceryListRepository.$groceries
            .assign(to: \.groceries, on: self)
            .store(in: &cancellables)
    }
    
    func addToList(_ groceryItem: Grocery) {
        groceryListRepository.addGrocery(listId: groceryList.id!, item: groceryItem)
    }
    
    func fetchGroceries() {
        groceryListRepository.getGroceries(id)
    }
    
    func delete(id: String) {
        groceryListRepository.delete(id: id)
    }
    
}
