//
//  homepage.swift
//  LoginCreditsystem
//
//  Created by luiz on 24/02/23.
//

import SwiftUI
import Firebase

struct homePage: View {
    @State  var isLoading = false
    @State private var statusMessage = ""
    @State private var showingLoanRequest = false
    @State private var showingRequestTracking = false 

    var body: some View {
        NavigationView {
            VStack {
                Text("Bem vindo ao sistema de credito da xxxxxxxx")
                    .font(.system(size: 34, weight:  .semibold))
                    .foregroundColor(.gray)
                
                Button(action: {
                    showingLoanRequest.toggle()
                }) {
                    Text("Solicitar empréstimo")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .sheet(isPresented: $showingLoanRequest) {
                   PedidoEmprestimoView()
                }
                
                Button(action: {
                    showingRequestTracking.toggle()
                }) {
                    Text("Acompanhar Solicitações")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .medium))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .sheet(isPresented: $showingRequestTracking) {
                    OutraView()
                }
            }
            .navigationTitle("Página Inicial")
        }
    }

    struct NovaView: View {
        var body: some View {
            Text("Nova View")
        }
    }
    
    struct OutraView: View {
        var body: some View {
            Text("Outra View")
        }
    }

    struct homePage_Previews: PreviewProvider {
        static var previews: some View {
            homePage()
        }
    }
}
