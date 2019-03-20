//
//  RegisterViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 3/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class RegisterViewModel {
    var isRegisterValidObserver: ((Bool) -> ())?
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
    fileprivate var isValid = false {
        didSet {
            isRegisterValidObserver?(isValid)
        }
    }
    fileprivate func registerMinimumTextValidation(name: String?, email: String?, password: String?) {
        let nameCount = name?.count ?? 0
        let emailCount = email?.count ?? 0
        let passwordCount = password?.count ?? 0
        let result = nameCount > 0 && emailCount > 3 && passwordCount > 5
        isValid = result
    }
    func isRegisterTextValid() -> Bool {
        return isValid
    }
}
