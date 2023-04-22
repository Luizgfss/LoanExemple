//
//  registerpage.swift
//  LoginCreditsystem
//
//  Created by luiz on 23/02/23.
//

import SwiftUI
import Firebase


struct registerPage: View {
    @State private var email = ""
    @State private var confirmEmail = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack (spacing: 15){
            Spacer()
            Text("Faça seu cadastro")
                .font(.system(size: 34, weight:  .semibold))
                .foregroundColor(.white)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Email", text: $email)
            }
                .padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Confirme seu mail", text: $confirmEmail)
            }
                .padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            
            
            VStack (spacing: 15){}
            
            
              
            
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("Senha", text: $password)
            }
                .padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("Confirme sua senha", text: $confirmPassword)
            }
                .padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            Button(action: {register()} ) {
                
                Text("Finalizar")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight:
                            .medium))
            } .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            Spacer()
           
        }.background(
            Image("credit")
                .resizable()
                .aspectRatio(contentMode: .fill)
        ).edgesIgnoringSafeArea(.all)
    }

func register() {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in if error != nil {
        print (error!.localizedDescription)
}
    }
}
}


struct registerPage_Previews: PreviewProvider {
    static var previews: some View {
        registerPage()
    }
}


