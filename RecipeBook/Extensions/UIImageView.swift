//
//  UIImageView.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/13/22.
//

import Foundation
import SwiftUI

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
