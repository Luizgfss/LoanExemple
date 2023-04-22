//
//  SwiftUIView.swift
//  LoginCreditsystem
//
//  Created by luiz on 11/04/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class LoanRequestManager {
    let db = Firestore.firestore()
    
    func createLoanRequest(request: LoanRequest, completion: @escaping (Error?) -> Void) {
        db.collection("loanRequests").addDocument(data: request.toDict()) { error in
            completion(error)
        }
    }
    
    func getLoanRequests(userId: String, completion: @escaping ([LoanRequest]?, Error?) -> Void) {
        db.collection("loanRequests").whereField("userId", isEqualTo: userId).getDocuments(source: FirestoreSource.cache) { snapshot, error in
            // ...
            guard let snapshot = snapshot else {
                completion(nil, error)
                return
            }
            
            let loanRequests = snapshot.documents.compactMap { document -> LoanRequest? in
                try? document.data(as: LoanRequest.self)
            }
            
            completion(loanRequests, nil)
        }
    }
    
    struct LoanRequest: Codable {
        var userId: String
        var amount: Double
        var duration: Int
        
        func toDict() -> [String: Any] {
            return [
                "userId": userId,
                "amount": amount,
                "duration": duration
            ]
        }
    }
}
