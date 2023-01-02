//
//  SearchRowView.swift
//  RecipeBooklet
//
//  Created by Tanner Rackow on 11/15/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchRowView: View {
    
    let snip: RecipeSnippet
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: snip.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .transition(.fade(duration: 0.5))
                .frame(width: CGFloat(80), height: CGFloat(80), alignment: .center)
            
            Text(snip.title).padding()
        }
    }
}
