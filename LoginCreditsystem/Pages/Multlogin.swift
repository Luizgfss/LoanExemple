
import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

extension LoginView{
    
    class GoogleSignInDelegate: NSObject, ObservableObject {
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            guard error == nil else {
                // Handle errors.
                return
            }
            print("Google Sign In - success")
        }
    }
    
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if error != nil {
                showError = true
            } else {
                userIsLoggedIn = true
            }
        }
    }
    
            
            
            
            
        }
    
    

