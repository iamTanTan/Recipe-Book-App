//
//  UserRepository.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import FirebaseFirestoreSwift
import Firebase
import Combine

class RecipeBookRepository: ObservableObject {
    
    private let path: String = "recipe_books"
    
    private let db = Firestore.firestore()
    
    @Published var bookList: [RecipeBooklet] = [RecipeBooklet]()
    @Published var bookRecipes: [Recipe] = [Recipe]()
    
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
                self?.getBookList()
            }
            .store(in: &cancellables)
    }
    
    
    func add(_ recipeBook: RecipeBooklet) {
        do {
            _ = try db.collection(path).addDocument(from: recipeBook)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func addRecipe(book_id: String, recipe: Recipe) {
        
        print(recipe)
        
        let recipeData: [String: Any] = [
            "name": recipe.name,
            "category": recipe.category,
            "author": recipe.author,
            "prepTime": recipe.prepTime,
            "cookTime": recipe.cookTime,
            "ingredients": recipe.ingredients,
            "steps": recipe.steps ,
            "isPublic": recipe.isPublic,
            "createdOn": recipe.createdOn,
            "updatedOn": recipe.updatedOn
        ]
        
        db.collection(path).document(book_id).updateData([
            "recipes" : FieldValue.arrayUnion([[recipeData]])
        ])
    }
    
    func getBookList() {
        db.collection(path).whereField("author", isEqualTo: userId).addSnapshotListener {(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let bookList = documents.compactMap {
                try? $0.data(as: RecipeBooklet.self)
            }
            
            DispatchQueue.main.async {
                self.bookList = bookList
            }
            
        }
    }
    
    func fetchRecipes(book_id: String) {
        bookRecipes.removeAll()
        db.collection(path).document(book_id)
            .getDocument(as: RecipeBooklet.self) { result in
                
                switch result {
                case .success(let book):
                    for recipe_id in book.recipeIds {
                        print("FETCH Firebase recipe: \(recipe_id)")
                        self.db.collection("recipes").document(recipe_id).getDocument(as: Recipe.self) {
                            res in
                            switch res {
                            case .success(let recipe):
                                DispatchQueue.main.async  {
                                    self.bookRecipes.append(recipe)
                                    print("\tfetched \(self.bookRecipes.count) recipes for book \(book_id)")
                                }
                            case .failure(let error):
                                print("Error decoding: \(error)")
                                // lets remove it from book collection array. this might not be best in practice
                                self.db.collection(self.path).document(book_id).updateData(["recipeIds": FieldValue.arrayRemove([recipe_id])])
                            }
                        }
                    }
                case .failure(let error):
                    print("Error decoding book: \(error)")
                }
            }
    }
    
    func deleteBook(id: String) {
        db.collection(path).document(id).delete()
    }
}
