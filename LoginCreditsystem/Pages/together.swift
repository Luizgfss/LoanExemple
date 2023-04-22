//
//  together.swift
//  LoginCreditsystem
//
//  Created by luiz on 23/02/23.
//

import SwiftUI

struct together: View {
    @AppStorage ("log_status") var logStatus: Bool = false
    
    var body: some View {
        if logStatus == true {
            homePage()
        }else{
            LoginView()
        }
    
        }
    }


