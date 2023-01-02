//
//  Profile.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Profile: Identifiable, Codable {
    
    // decorator from FirebaseFirestoreSwift
    @DocumentID  var id: String?
    var emailAddress: String
    var name: String
    var phoneNumber: String?
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
