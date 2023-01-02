//
//  UserRepository.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import FirebaseFirestoreSwift
import Firebase
import Combine

class ProfileRepository: ObservableObject {
    
    private let path: String = "profiles"
    
    private let db = Firestore.firestore()
    
    private var profile: Profile?
    
    func add(_ profile: Profile) {
        do {
            _ = try db.collection(path).addDocument(from: profile)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func getProfile(_ email: String) -> Profile? {
        
        let docRef = db.collection("profiles").document(email)
        
        docRef.getDocument(as: Profile.self) { result in

            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                print("Error decoding city: \(error)")
            }
        }
        return self.profile
    }
}
