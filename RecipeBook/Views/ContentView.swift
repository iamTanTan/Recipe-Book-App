//
//  ContentView.swift
//  RecipeBook
//
//  Created by trackow on 10/18/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        ZStack {
          
            
            if authModel.user != nil {
                TabbedView()
            } else {
                LoginView()
            }
        }
    }
}
