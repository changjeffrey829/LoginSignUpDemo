//
//  ViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 3/2/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class LoginViewModel {
    var bindableIsLoginValid = Bindable<Bool>()
    var loginEmail: String? {
        didSet {
            loginMinimumTextValidation(email: loginEmail, password: loginPassword)}
    }
    var loginPassword: String? {
        didSet {
            loginMinimumTextValidation(email: loginEmail, password: loginPassword)}
    }
    fileprivate var isValid = false {
        didSet {
            bindableIsLoginValid.value = isValid
        }
    }
    fileprivate func loginMinimumTextValidation(email: String?, password: String?) {
        let emailCount = email?.count ?? 0
        let passwordCount = password?.count ?? 0
        let result = emailCount > 3 && passwordCount > 5
        isValid = result
    }
    
    func performLogin(completion:()->()) {
        guard
            let email = loginEmail,
            let password = loginPassword
            else {return}
        print("LOGIN => Email: \(email), Password: \(password)")
    }
    
    func isLoginTextValid() -> Bool {
        return isValid
    }
}


