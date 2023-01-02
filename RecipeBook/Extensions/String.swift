//
//  String.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/17/22.
//

import Foundation

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
