//
//  homepage.swift
//  LoginCreditsystem
//
//  Created by luiz on 24/02/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct homePage: View {
    @State  var isLoading = false
    @State private var statusMessage = ""
    @State private var showingLoanRequest = false
    @State private var showingRequestTracking = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("O que deseja fazer hoje?")
                
                    .font(.system(size: 34, weight:   .semibold))
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                
                
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
                    LoanRequestView()
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
                    LoanStatusView()
                }
            }
            .navigationTitle("Olá...... ")
            .font(.system(size: 34, weight:  .semibold))
            .foregroundColor(.gray)
            
            .background(
                Image("home")
                
                    .frame(maxWidth: .infinity)
            )
        }
    }
    
    
    
    struct LoanStatusView: View {
        @State private var loanRequests: [LoanRequest] = []
        
        var body: some View {
            VStack {
                Text("Acompanhamento de Solicitações")
                    .font(.title)
                    .padding()
                
                if loanRequests.isEmpty {
                    Text("Nenhuma solicitação de empréstimo encontrada.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(loanRequests, id: \.userId) { request in
                        LoanRequestRow(request: request)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .padding()
            .onAppear {
                loadLoanRequests()
            }
        }
        
        private func loadLoanRequests() {
            let db = Firestore.firestore()
            let loanRequestsCollection = db.collection("loanRequests")
            
            loanRequestsCollection.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Erro ao buscar as solicitacoes de emprestimo: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Solicitacoes de emprestimo não encontradas")
                    return
                }
                
                self.loanRequests = documents.compactMap { document in
                    do {
                        let result = try document.data(as: LoanRequest.self)
                        return result
                    } catch {
                        print("Erro interno de decoding: \(error)")
                        return nil
                    }
                }
            }
        }
    }
    
    struct LoanRequestRow: View {
        let request: LoanRequest
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("Usuário: \(request.userId)")
                    .font(.headline)
                Text("Valor: R$\(String(format: "%.2f", request.amount))")
                Text("Prazo: \(request.duration) meses")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
    struct homePage_Previews: PreviewProvider {
        static var previews: some View {
            homePage()
        }
    }
    
}
