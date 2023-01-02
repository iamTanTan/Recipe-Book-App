//
//  Category.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
}
