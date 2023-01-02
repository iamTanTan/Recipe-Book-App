//
//  RecipeListViewModel.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/6/22.
//

import Foundation
import Combine

final class RecipeListViewModel: ObservableObject {
    
    @Published var recipeViewModels: [RecipeViewModel] = []
    private var recipeRepository: RecipeRepository = RecipeRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        recipeRepository.$myRecipes.map { recipes in
            recipes.map(RecipeViewModel.init)
        }
        .assign(to: \.recipeViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func add(recipe: Recipe) {
        recipeRepository.addRecipe(recipe)
    }
    
    
    func addRecipeIdToBook(_ bookId: String, _ recipeId: String) {
        recipeRepository.addRecipeIdToBook(book_id: bookId, recipe_id: recipeId)
    }
    
    func delete(id: String) {
        recipeRepository.delete(id: id)
    }
    
    func deleteAtOffsets(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let deletedItemId = recipeViewModels[i].id
            delete(id: deletedItemId)
        }
    }
    
}
