//
//  Grocery.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Grocery: Identifiable, Codable {
    @DocumentID var id: String?
    var list_id: String
    var name: String
    var isBought: Bool = false
    var amount: Double
    var modifier: String?
}
