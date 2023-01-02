//
//  RecipeBookListViewModel.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import Combine

final class RecipeBookListViewModel: ObservableObject {
    
    @Published var recipeBookViewModels: [RecipeBookViewModel] = []
    private var recipeBookRepository: RecipeBookRepository = RecipeBookRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        recipeBookRepository.$bookList.map { books in
            books.map(RecipeBookViewModel.init)
        }
        .assign(to: \.recipeBookViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func add(recipeBook: RecipeBooklet) {
        recipeBookRepository.add(recipeBook)
    }
    
}
