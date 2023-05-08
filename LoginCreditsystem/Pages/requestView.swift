import SwiftUI
import Firebase

// Estrutura que representa uma solicitação de empréstimo
struct LoanRequest: Codable {
    let userId: String
    let amount: Double
    let duration: Int
}

// Visualização da solicitação de empréstimo
struct LoanRequestView: View {
    @State private var loanAmount = "" // Valor do empréstimo digitado pelo usuário
    @State private var loanDuration = "" // Duração do empréstimo digitada pelo usuário
    @State private var errorMessage = "" // Mensagem de erro, se houver
    @State private var isRequestSent = false // Flag indicando se a solicitação foi enviada
    
    var body: some View {
        VStack {
            Text("Solicitação de empréstimo")
                .font(.title)
                .padding()
            
            AmountInputView(loanAmount: $loanAmount) // Visualização para entrada do valor do empréstimo
            
            DurationInputView(loanDuration: $loanDuration) // Visualização para entrada da duração do empréstimo
            
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Button("Enviar solicitação") {
                guard let userId = Auth.auth().currentUser?.uid, // Obtém o ID do usuário autenticado
                      let amount = Double(loanAmount), // Converte o valor do empréstimo para um número de ponto flutuante
                      let duration = Int(loanDuration) else { // Converte a duração do empréstimo para um número inteiro
                    self.errorMessage = "Por favor, preencha todos os campos corretamente."
                    return
                }
                
                let loanRequest = LoanRequest(userId: userId, amount: amount, duration: duration) // Cria um objeto LoanRequest
                
                let loanRequestManager = LoanRequestManager() // Cria uma instância de LoanRequestManager
                let managerRequest = LoanRequestManager.LoanRequest(userId: loanRequest.userId, amount: loanRequest.amount, duration: loanRequest.duration) // Cria uma estrutura LoanRequest para ser passada para o LoanRequestManager
                
                loanRequestManager.createLoanRequest(request: managerRequest) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.isRequestSent = true
                    }
                }
            }
            .buttonStyle(DesignButton(color: .blue))
            .padding()
            
            if isRequestSent {
                Text("Sua solicitação foi enviada com sucesso!")
                    .foregroundColor(.green)
                    .padding()
                LoginView()
            }
            
            Spacer()
        }
        .padding()
    }
}

// Visualização para entrada do valor do empréstimo
struct AmountInputView: View {
    @Binding var loanAmount: String // Valor do empréstimo digitado pelo usuário
    
    var body: some View {
        VStack {
            Text("Valor desejado")
                .padding()
            
            TextField("0.00", text: $loanAmount)
                .keyboardType(.decimalPad)
                .padding()
        }
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                       .padding()
           }
       }

       // Visualização para entrada da duração do empréstimo
       struct DurationInputView: View {
           @Binding var loanDuration: String // Duração do empréstimo digitada pelo usuário
           
           var body: some View {
               VStack {
                   Text("Prazo de pagamento (meses)")
                       .padding()
                   
                   TextField("0", text: $loanDuration)
                       .keyboardType(.numberPad)
                       .padding()
               }
               .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
               .padding()
           }
       }

       // Estilo personalizado para o botão
       struct DesignButton: ButtonStyle {
           let color: Color
           
           func makeBody(configuration: Configuration) -> some View {
               configuration.label
                   .padding()
                   .background(color)
                   .foregroundColor(.white)
                   .cornerRadius(10)
           }
       }

       // Classe que gerencia a criação da solicitação de empréstimo
       class PedidoEmprestimoManager {
           struct LoanRequest {
               let userId: String
               let amount: Double
               let duration: Int
           }
           
           func createLoanRequest(request: LoanRequest, completion: @escaping (Error?) -> Void) {
               // Implementação de createLoanRequest
           }
       }
