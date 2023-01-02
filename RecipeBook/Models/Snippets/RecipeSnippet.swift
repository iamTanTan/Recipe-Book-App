//
//  RecipeSnippet.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/15/22.
//

import Foundation

struct RecipeSnippet: Decodable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
