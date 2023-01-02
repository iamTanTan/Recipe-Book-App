//
//  RegisterView.swift
//  RecipeBooklet
//
//  Created by Tanner Rackow on 10/27/22.
//


import SwiftUI
import Firebase

struct RegisterView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    @State var triesToLogIn: Bool = false
    
    var body: some View {
        if triesToLogIn {
            LoginView()
        }
        else {
            ZStack {
                VStack {
                    Text("Sign up").font(.title)
                    TextField("Email", text: $email).autocapitalization(.none).textFieldStyle(.roundedBorder).padding()
                    SecureField("Password", text: $password).textFieldStyle(.roundedBorder).padding()
                    SecureField("Confirm Password", text: $passwordConfirm).textFieldStyle(.roundedBorder).padding()
                    Button(action: { register() }) {
                        Text("Sign up")
                    }.buttonStyle(.borderedProminent)
                        .padding()
                    
                    Button( action: {triesToLogIn.toggle()}) {
                        Text("Log In")
                    }.buttonStyle(.bordered)
                }.padding()
            }
        }
    }
    
    func register() {
        
        if password == passwordConfirm {
            authViewModel.signUp(emailAddress: email.lowercased(), password: password)
            
            if let user = authViewModel.user {
                ProfileRepository().add(Profile(emailAddress: email.lowercased(), name: "test", phoneNumber: "14804665925", updatedOn: Date()))
                profileViewModel.profile = ProfileRepository().getProfile(user.email!)
            }
        }
    }
}
