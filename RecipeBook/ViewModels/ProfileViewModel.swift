//
//  UserViewModel.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published var profile: Profile?
    private var profileRepository = ProfileRepository()
    
    func add(profile: Profile) {
        profileRepository.add(profile)
    }
    
    func getProfile() -> Profile? {
        return profile
    }
}
