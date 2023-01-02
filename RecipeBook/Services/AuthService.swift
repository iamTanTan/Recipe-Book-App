//
//  AuthService.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 11/6/22.
//

import Foundation
import Firebase

//class AuthService: ObservableObject {
//  @Published var user: User?
//  private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
//
//  static let instance = AuthService()
//  init() {
//    addListeners()
//  }
//
//  static func signIn() {
//    if Auth.auth().currentUser == nil {
//      Auth.auth().signInAnonymously()
//    }
//  }
//
//  private func addListeners() {
//    if let handle = authenticationStateHandler {
//      Auth.auth().removeStateDidChangeListener(handle)
//    }
//
//    authenticationStateHandler = Auth.auth()
//      .addStateDidChangeListener { _, user in
//        self.user = user
//      }
//  }
//}
