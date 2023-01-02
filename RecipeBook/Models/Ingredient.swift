//
//  Ingredient.swift
//  RecipeMockup-SwiftUI
//
//  Created by Tanner Rackow on 10/22/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Ingredient: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var amount: Double
    var modifier: String?
    var unit: String?
}
