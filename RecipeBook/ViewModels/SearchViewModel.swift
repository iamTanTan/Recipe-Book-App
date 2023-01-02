//
//  SearchViewModel.swift
//  RecipeBook
//
//  Created by trackow on 11/8/22.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    @Published var recipeSnippets: RecipeSnippets?
    @Published var currentRecipe: Recipe?
    private var recipeRepository: RecipeRepository = RecipeRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        search("")
    }
    
    func add(recipe: Recipe) {
        recipeRepository.addRecipe(recipe)
    }
    
    func search(_ query: String) {
        // dont steal my API Key thx!
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&number=100&apiKey=bfa6af1d145a43fea5065957f4e82170") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data{
                do{
                    let tasks = try decoder.decode(RecipeSnippets.self, from: data)
                    DispatchQueue.main.async  {
                        self.recipeSnippets = tasks
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
        
    }
    
    func getRecipeInfo(_ id: Int) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=bfa6af1d145a43fea5065957f4e82170") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            print("FETCH recipe details")
            
            if let data = data{
                do{
                    let spoontacularRecipe = try JSONDecoder().decode(SpoontacularRecipe.self, from: data)
                    
                    var instructionsAsOne: [String] = []
                    if spoontacularRecipe.instructions != nil {
                        instructionsAsOne.append(spoontacularRecipe.instructions!.html2String)
                    }
                    
                    var fetchedIngredients: [Ingredient] = []
                    
                    spoontacularRecipe.extendedIngredients?.forEach {
                        fetchedIngredients.append(Ingredient(name: $0.name ?? "unknown ingredient", amount: Double($0.measures?.us?.amount ?? 0.0), unit: $0.measures?.us?.unitShort ?? ""))
                    }
                    
                    DispatchQueue.main.async {
                        self.currentRecipe = Recipe(id: String(spoontacularRecipe.id), name: spoontacularRecipe.title, category: "unknown", author: "Spoonacular API", prepTime: 0, cookTime: spoontacularRecipe.readyInMinutes ?? 0, ingredients: fetchedIngredients, steps: instructionsAsOne, isPublic: true, recipeUrl: spoontacularRecipe.sourceURL, imageUrl: spoontacularRecipe.image, createdOn: Date(), updatedOn: Date())
                    }
                    
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
        
    }
    
    struct RecipeSnippets: Decodable {
        let results: [RecipeSnippet]
    }
    
}
