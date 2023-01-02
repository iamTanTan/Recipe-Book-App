//
//  Recipe.swift
//  RecipeMockup-SwiftUI
//
//  Created by trackow on 10/20/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var category: String
    var author: String
    var prepTime: Int
    var cookTime: Int
    var ingredients: [Ingredient]
    var steps: [String]
    var isPublic: Bool
    var recipeUrl: String?
    var imageUrl: String?
    
    var createdOn: Date = Date()
    var updatedOn: Date
    
    var totalTime: Int {
        return cookTime + prepTime
    }
    
    var createdOnString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.string(from: createdOn)
    }
    
    var updatedOnString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.string(from: updatedOn)
    }
}
