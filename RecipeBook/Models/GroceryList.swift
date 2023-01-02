//
//  GroceryList.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import Foundation
import FirebaseFirestoreSwift

struct GroceryList: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var creator: String?

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
