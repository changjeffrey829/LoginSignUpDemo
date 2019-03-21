//
//  ViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 3/2/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class LoginViewModel {
//    var isLoginValidObserver: ((Bool) -> ())?
    var bindableIsLoginValid = Bindable<Bool>()
    var LoginEmail: String? {
        didSet {
            loginMinimumTextValidation(email: LoginEmail, password: LoginPassword)}
    }
    var LoginPassword: String? {
        didSet {
            loginMinimumTextValidation(email: LoginEmail, password: LoginPassword)}
    }
    fileprivate var isValid = false {
        didSet {
//            isLoginValidObserver?(isValid)
            bindableIsLoginValid.value = isValid
        }
    }
    fileprivate func loginMinimumTextValidation(email: String?, password: String?) {
        let emailCount = email?.count ?? 0
        let passwordCount = password?.count ?? 0
        let result = emailCount > 3 && passwordCount > 5
        isValid = result
    }
    func isLoginTextValid() -> Bool {
        return isValid
    }
}


