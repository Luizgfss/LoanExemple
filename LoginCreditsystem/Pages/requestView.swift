import SwiftUI
import Firebase

struct LoanRequest {
let userId: String
let amount: Double
let duration: Int
}

struct PedidoEmprestimoView: View {
    @State private var loanAmount = ""
    @State private var loanDuration = ""
    @State private var errorMessage = ""
    @State private var isRequestSent = false
    var body: some View {
        VStack {
            Text("Solicitação de empréstimo")
                .font(.title)
                .padding()
            
            TextField("Valor desejado", text: $loanAmount)
                .keyboardType(.decimalPad)
                .padding()
            
            TextField("Prazo de pagamento (meses)", text: $loanDuration)
                .keyboardType(.numberPad)
                .padding()
            
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Button("Enviar solicitação") {
                guard let userId = Auth.auth().currentUser?.uid,
                      let amount = Double(loanAmount),
                      let duration = Int(loanDuration) else {
                    self.errorMessage = "Por favor, preencha todos os campos corretamente."
                    return
                }
                
                let loanRequest = LoanRequest(userId: userId, amount: amount, duration: duration)
                let manager = LoanRequestManager()
                let managerRequest = LoanRequestManager.LoanRequest(userId: loanRequest.userId, amount: loanRequest.amount, duration: loanRequest.duration)
                
                manager.createLoanRequest(request: managerRequest) { error in
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

struct PedidoEmprestimo: View {
var body: some View {
// Your implementation here
EmptyView()
}
}

class PedidoEmprestimoManager {
    struct PedidoEmprestimo {
        let userId: String
        let amount: Double
        let duration: Int
    }
    
    func createPedidoEmprestimo(request: PedidoEmprestimo, completion: @escaping (Error?) -> Void) {
        // Your implementation here
    }
}
