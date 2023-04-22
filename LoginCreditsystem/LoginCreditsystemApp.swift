//
//  LoginCreditsystemApp.swift
//  LoginCreditsystem
//
//  Created by luiz on 22/02/23.
//

import SwiftUI
import FirebaseCore
import FirebaseStorage
import GoogleSignIn

@main



struct LoginCreditsystemApp: App {
    
    
    init() {
        
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup{
                together()
            }
           
        }
    
    struct homepage_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    }


