//
//  ViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 3/2/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class LoginRegisterViewModel {
    var isLoginValid = false
    var isRegisterValid = false
    var LoginEmail: String? {
        didSet {
            loginMinimumTextValidation(email: LoginEmail, password: LoginPassword)}
    }
    var LoginPassword: String? {
        didSet {
            loginMinimumTextValidation(email: LoginEmail, password: LoginPassword)}
    }
    var RegisterEmail: String? {
        didSet {
            registerMinimumTextValidation(name: RegisterName, email: RegisterEmail, password: RegisterPassword)}
    }
    var RegisterName: String? {
        didSet {
            registerMinimumTextValidation(name: RegisterName, email: RegisterEmail, password: RegisterPassword)}
    }
    var RegisterPassword: String? {
        didSet {
            registerMinimumTextValidation(name: RegisterName, email: RegisterEmail, password: RegisterPassword)}
    }
    
    var isFormValidObserver: ((Bool) -> ())?
    
    fileprivate func loginMinimumTextValidation(email: String?, password: String?) {
        let emailCount = email?.count ?? 0
        let passwordCount = password?.count ?? 0
        let result = emailCount > 3 && passwordCount > 5
        isFormValidObserver?(result)
        isLoginValid = result
    }
    fileprivate func registerMinimumTextValidation(name: String?, email: String?, password: String?) {
        let nameCount = name?.count ?? 0
        let emailCount = email?.count ?? 0
        let passwordCount = password?.count ?? 0
        let result = nameCount > 0 && emailCount > 3 && passwordCount > 5
        isFormValidObserver?(result)
        isRegisterValid = result
    }
}
