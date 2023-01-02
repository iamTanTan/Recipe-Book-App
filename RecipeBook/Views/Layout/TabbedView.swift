//
//  TabbedView.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import SwiftUI

struct TabbedView: View {
    
    //    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    
    enum Tabs: String{
        case books = "My Recipe Books"
        case recipes = "My Recipes"
        case search = "Search Recipes"
        case groceries = "Grocery Lists"
        //        case profile
    }
    
    @State var selectedTab: Tabs = .books
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            
            NavigationView {
                    RecipeBookListView()
                        .navigationTitle(selectedTab.rawValue.capitalized)
            }
            .tabItem {
                Text("Recipe Books")
                Image(systemName: "books.vertical")
            }.tag(Tabs.books)
            
            NavigationView {
                RecipeListView()
                    .navigationTitle(selectedTab.rawValue.capitalized)
            }
            .tabItem {
                Text("My Recipes")
                Image(systemName: "book.fill")
            }.tag(Tabs.recipes)
            
            NavigationView {
                SearchView()
                    .navigationTitle(selectedTab.rawValue.capitalized)
            }
            .tabItem {
                Text("Search Recipes")
                Image(systemName: "magnifyingglass")
            }.tag(Tabs.search)
            
            NavigationView {
                GroceryListCollectionView()
                    .navigationTitle(selectedTab.rawValue.capitalized)
            }
            .tabItem {
                Text("Grocery Lists")
                Image(systemName: "pencil")
            }.tag(Tabs.groceries)
            
            //            NavigationView {
            //                Button("Sign Out") {authViewModel.signOut()}
            //                    .navigationTitle(selectedTab.rawValue.capitalized)
            //            }
            //            .tabItem {
            //                Text("Profile")
            //                Image(systemName: "person")
            //            }.tag(Tabs.profile)
            
        }.onAppear {
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithDefaultBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
    }
}

