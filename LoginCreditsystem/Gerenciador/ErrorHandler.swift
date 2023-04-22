//
//  ErrorHandler.swift
//  LoginCreditsystem
//
//  Created by luiz on 20/04/23.
//

import Foundation

enum StatusCode : Int {
    case successRequest
    case badRequest
    
    var range:Range<Int> {
        switch self {
        case .successRequest : return 200..<300
        case .badRequest : return 400..<500
        }
    }
}


enum ErrorDefault: String {
    
    case loadDataResponse = "Erro ao carregar os dados"
    case urlLoad = "Erro ao carregar a URL"
    case tittleError = "Error"
}

protocol ErrorHandlerProtocol : LocalizedError {
    
    var title: String? { get }
    var code: Int { get }
}

struct ErrorHandler: ErrorHandlerProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description}
    var failureReason: String? { return _description}
    
    private var _description : String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
    
    init(error: Error, code: Int) {
        self.title = "Error"
        self._description = error.localizedDescription
        self.code = code
    }
}

