import SwiftUI
import Firebase


struct LoanRequest: Codable {
   
    let userId: String
    let amount: Double
    let duration: Int
}

struct LoanRequestView: View {
    @State private var loanAmount = ""
    @State private var loanDuration = ""
    @State private var errorMessage = ""
    @State private var isRequestSent = false
    
    var body: some View {
        VStack {
            Text("Solicitação de empréstimo")
                .font(.title)
                .padding()
            
            AmountInputView(loanAmount: $loanAmount)
            
            DurationInputView(loanDuration: $loanDuration)
            
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
                let loanRequestManager = LoanRequestManager()
                let managerRequest = LoanRequestManager.LoanRequest(userId: loanRequest.userId, amount: loanRequest.amount, duration: loanRequest.duration)
                
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

struct AmountInputView: View {
    @Binding var loanAmount: String
    
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

struct DurationInputView: View {
    @Binding var loanDuration: String
    
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

class PedidoEmprestimoManager {
    struct LoanRequest {
        let userId: String
        let amount: Double
        let duration: Int
    }
    
    func createLoanRequest(request: LoanRequest, completion: @escaping (Error?) -> Void) {
        // Implementation of createLoanRequest
    }
}
