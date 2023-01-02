//
//  RecipeBookViewModel.swift
//  RecipeBook
//
//  Created by trackow on 11/3/22.
//

import Combine

final class RecipeBookViewModel: ObservableObject, Identifiable {
    
    @Published var book: RecipeBooklet
    @Published var bookRecipes: [Recipe] = []
    @Published var recipeViewModels: [RecipeViewModel] = []
    private let recipeBookRepository = RecipeBookRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    
    init(book: RecipeBooklet) {
        self.book = book
        $book.compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        // initially fetch on creation
        fetchBookRecipes()
        
        recipeBookRepository.$bookRecipes
            .assign(to: \.bookRecipes, on: self)
            .store(in: &cancellables)
            
        recipeBookRepository.$bookRecipes.map{ recipes in recipes.map(RecipeViewModel.init)}
            .assign(to: \.recipeViewModels, on: self)
            .store(in: &cancellables)
    
    }
    
    func addRecipe(recipe: Recipe) {
        recipeBookRepository.addRecipe(book_id: id, recipe: recipe)
    }
    
    func fetchBookRecipes() {
        recipeBookRepository.fetchRecipes(book_id: id)
        recipeBookRepository.$bookRecipes
            .assign(to: \.bookRecipes, on: self)
            .store(in: &cancellables)
    }
    
    func delete(id: String) {
        recipeBookRepository.deleteBook(id: id)
    }
    
}
