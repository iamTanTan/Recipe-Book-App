//
//  RecipeRepository.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/6/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class RecipeRepository: ObservableObject {
    
    private let path: String = "recipes"
    
    private let db = Firestore.firestore()
    
    @Published var myRecipes: [Recipe] = [Recipe]()
    @Published var searchRecipes: [Recipe] = [Recipe]()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var authVM = AuthViewModel()
    
    var userId = ""
    
    init() {
        userId = Auth.auth().currentUser?.uid ?? ""
        authVM.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        authVM.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.getMyRecipes()
            }
            .store(in: &cancellables)
    }
    
    
    func addRecipe(_ recipe: Recipe) {
        do {
            var newRecipe = recipe
            newRecipe.author = userId
            _ = try db.collection(path).addDocument(from: newRecipe)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func addRecipeIdToBook(book_id: String, recipe_id: String) {
        let ref = db.collection("recipe_books").document(book_id)
        ref.setData(["recipeIds": FieldValue.arrayUnion([recipe_id])], merge: true)
    }
    
    func getMyRecipes() {
        
        db.collection(path).whereField("author", isEqualTo: userId).addSnapshotListener {(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let myRecipes = documents.compactMap {
                try? $0.data(as: Recipe.self)
            }
            
            DispatchQueue.main.async {
                self.myRecipes = myRecipes
            }
        }
    }
    
    // TODO: Technically should cascade... Should have used a relational DB
    func delete(id: String) {
        db.collection(path).document(id).delete()
    }
}
