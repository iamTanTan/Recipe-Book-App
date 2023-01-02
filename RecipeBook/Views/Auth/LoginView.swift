//
//  LoginView.swift
//  RecipeBook
//
//  Created by trackow on 10/18/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State var triesToSignUp: Bool = false
    
    var body: some View {
        if !triesToSignUp {
            ZStack {
        
                VStack {
                    Text("Sign in").font(.title)
                    TextField("Email", text: $email).autocapitalization(.none).textFieldStyle(.roundedBorder).padding()
                    SecureField("Password", text: $password).textFieldStyle(.roundedBorder).padding()
                    Button(action: { login() }) {
                        Text("Sign in")
                    }.buttonStyle(.borderedProminent)
                    
                    Button( action: {triesToSignUp.toggle()}) {
                        Text("Sign Up")
                    }.buttonStyle(.bordered).padding(.top)
                }
                .padding()
            }.padding()
        }
        else if triesToSignUp {
            RegisterView()
        }
    }
    
    func login() {
        authViewModel.signIn(emailAddress: email, password: password)
    }
}
