//
//  RecipeViewModel.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/6/22.
//

import Combine

final class RecipeViewModel: ObservableObject, Identifiable {
    
    @Published var recipe: Recipe
    private let recipeRepository = RecipeRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    
    init(recipe: Recipe) {
        self.recipe = recipe
        $recipe.compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func add(recipe: Recipe) {
        recipeRepository.addRecipe(recipe)
    }
    
    func delete(id: String) {
        recipeRepository.delete(id: id)
    }
    
}
