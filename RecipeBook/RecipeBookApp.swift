//
//  RecipeBookApp.swift
//  RecipeBook
//
//  Created by trackow on 10/18/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  
        FirebaseApp.configure()

        // Persistence is enabled by default
        return true
    }
}

@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authVM = AuthViewModel()
    @StateObject var profileVM = ProfileViewModel()
    @StateObject var bookListVM = RecipeBookListViewModel()
    @StateObject var recipeListVM = RecipeListViewModel()
    @StateObject var groceryListCollectionVM = GroceryListCollectionViewModel()
    @StateObject var searchVM = SearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(authVM)
                .environmentObject(profileVM)
                .environmentObject(bookListVM)
                .environmentObject(recipeListVM)
                .environmentObject(groceryListCollectionVM)
                .environmentObject(searchVM)
        }
    }
}
