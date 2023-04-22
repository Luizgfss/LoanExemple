//
//  AppDelegateAdaptor.swift
//  LoginCreditsystem
//
//  Created by luiz on 23/02/23.
//

import SwiftUI
import FirebaseStorage
import GoogleSignIn
import FirebaseAuth
import Firebase
import FirebaseCore




extension LoginCreditsystemApp{
    
    class GoogleSignInDelegate: NSObject,  ObservableObject {
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            guard error == nil else {
                // Handle errors.
                return
            }
            print("Google Sign In - success")
        }
    }
    
}
