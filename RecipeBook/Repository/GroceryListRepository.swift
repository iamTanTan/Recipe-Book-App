//
//  GroceryListRepository.swift
//  RecipeBook
//
//  Created by trackow on 11/8/22.
//

import FirebaseFirestoreSwift
import Firebase
import Combine

class GroceryListRepository: ObservableObject {
    
    private let path: String = "grocery_lists"
    
    private let db = Firestore.firestore()
    
    @Published var groceryListCollection: [GroceryList] = [GroceryList]()
    @Published var groceries: [Grocery] = [Grocery]()
    
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
                self?.getGroceryLists()
            }
            .store(in: &cancellables)
    }
    
    
    func add(_ list: GroceryList) {
        do {
            var newList = list
            newList.creator = userId
            _ = try db.collection(path).addDocument(from: newList)
        } catch {
            fatalError("Unable to add: \(error.localizedDescription).")
        }
    }
    
    func addGrocery(listId: String, item: Grocery) {
        
        do {
            var addGrocery = item
            addGrocery.list_id = listId
            let _ = try db.collection("groceries").addDocument(from: addGrocery)
        } catch {
            fatalError("grocery failed to add (Repo)")
        }
        
        
    }
    
    func getGroceryLists() {
        db.collection(path).whereField("creator", isEqualTo: userId).addSnapshotListener {(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let groceryLists = documents.compactMap {
                try? $0.data(as: GroceryList.self)
            }
            
            DispatchQueue.main.async {
                self.groceryListCollection = groceryLists
            }
            
        }
    }
    
    
    
    func setBought(grocery: Grocery) {
        
        let ref = db.collection("groceries").document(grocery.id!)
        ref.updateData(["isBought": !grocery.isBought]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func getGroceries(_ list_id: String) {
        
        print("Fetch Groceries")
        
        db.collection("groceries").whereField("list_id", isEqualTo: list_id).addSnapshotListener {(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let groceries = documents.compactMap {
                try? $0.data(as: Grocery.self)
            }
            
            DispatchQueue.main.async {
                self.groceries = groceries
                print("DispatchQueue Groceries: \(groceries)")
            }
            
        }
    }
    
    func addListWithGroceries(_ list: GroceryList, _ groceries: [Grocery]) {
        
        do {
            print("\n---- Gen Grocery List ----")
            var newList = list
            newList.creator = userId
            let addedList =  try db.collection(path).addDocument(from: newList)
            print("---- End Gen Grocery List ----")
            
            print("---- Gen Groceries ----")
            for grocery in groceries {
                var addGrocery = grocery
                addGrocery.list_id = addedList.documentID
                let _ = try db.collection("groceries").addDocument(from: addGrocery)
            }
            print("---- End Gen Groceries ----")
        }
        catch {
            fatalError("Generated List Error (Repo)")
        }
        
    }
    
    func delete(id: String) {
        db.collection(path).document(id).delete()
    }
}
