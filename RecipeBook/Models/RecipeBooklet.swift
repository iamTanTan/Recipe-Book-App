//
//  RecipeBooklet.swift
//  RecipeMockup-SwiftUI
//
//  Created by trackow on 10/20/22.
//

import Foundation
import FirebaseFirestoreSwift

struct RecipeBooklet: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var recipes: [Recipe]?
    var recipeIds: [String]
    var author: String?
    var createdOn: Date = Date()
    var updatedOn: Date
    
    var createdOnString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: createdOn)
    }
    
    var updatedOnString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: updatedOn)
    }
}
