//
//  LoginView.swift
//  LoginCreditsystem
//
//  Created by luiz on 22/02/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import GoogleSignIn
import SwiftUI

struct GoogleSignInButton: UIViewRepresentable {

    @Environment(\.colorScheme) var colorScheme

    private var button: GIDSignInButton = GIDSignInButton()

    func makeUIView(context: Context) -> GIDSignInButton {
        button.colorScheme = self.colorScheme == .dark ? .dark : .light
        return button
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        button.colorScheme = self.colorScheme == .dark ? .dark : .light
    }
}


extension LoginCreditsystemApp {
   func setupAuthentication() {
    FirebaseApp.configure()
  }
}


struct LoginView: View {
    
    
    
    @State  var email = ""
    @State  var password = ""
    @State  var userIsLoggedIn = false
    @State  var showError = false
    @State  var isLoading = false
    
    
    func showError(error: Error) -> Void {
    }
    struct ActivityIndicator: UIViewRepresentable {
        func makeUIView(context: Context) -> UIActivityIndicatorView {
            let view = UIActivityIndicatorView(style: .medium)
            view.startAnimating()
            return view
        }
        
        func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing: 15) {
                Spacer()
                Text("Sistema De Crédito")
                    .font(.system(size: 34, weight:  .semibold))
                    .foregroundColor(.white)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Usuário", text: $email)
                }
                .padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Senha", text: $password)
                }
                .padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
                Button(action: {login()} ) {
                    if isLoading {
                        ActivityIndicator()
                    } else {
                        Text("Entrar")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .medium))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .disabled(isLoading)
                .alert(isPresented: $showError) {
                    Alert(
                        title: Text("Erro"),
                        message: Text("Não foi possível fazer o login. Verifique suas credenciais e tente novamente."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding(.bottom, 10)
                
                Button(action: {} ) {
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 20)
                        Text("Entrar com Google")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .medium))
                        
                            .padding(.trailing, 20)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .disabled(isLoading)
                .padding(.bottom, 10)
                
                NavigationLink(destination: homePage(), isActive: $userIsLoggedIn) {
                    EmptyView()
                }
                .hidden()
                NavigationLink(destination: registerPage()) {
                    Text("Não tem uma conta? Junte-se a nós")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.vertical, 20)
                }
                
                ZStack{
                }
                Spacer()
                
            }
            .background(
                Image("credit")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    
    
    



   

}

