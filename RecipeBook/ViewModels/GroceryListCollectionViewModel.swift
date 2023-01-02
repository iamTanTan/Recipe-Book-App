//
//  GroceryListCollectionViewModel.swift
//  RecipeBook
//
//  Created by trackow on 11/8/22.
//

import Foundation
import Combine

final class GroceryListCollectionViewModel: ObservableObject {
    
    @Published var groceryListViewModels: [GroceryListViewModel] = []
    private var groceryListRepository: GroceryListRepository = GroceryListRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        groceryListRepository.$groceryListCollection.map { lists in
            lists.map(GroceryListViewModel.init)
        }
        .assign(to: \.groceryListViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func add(_ groceryList: GroceryList) {
        groceryListRepository.add(groceryList)
    }
    
    func delete(id: String) {
        groceryListRepository.delete(id: id)
    }
    
    func generateGroceryList(_ list: GroceryList, _ groceries: [Grocery]) {
        groceryListRepository.addListWithGroceries(list, groceries)
    }
    
    func updateGroceryStatus(grocery: Grocery) {
        groceryListRepository.setBought(grocery: grocery)
    }
    
    
    func deleteFromList(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let deletedItemId = groceryListViewModels[i].id
            delete(id: deletedItemId)
        }
    }
    
}
