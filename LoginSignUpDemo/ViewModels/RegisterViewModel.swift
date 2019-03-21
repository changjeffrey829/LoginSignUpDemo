//
//  RegisterViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 3/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class RegisterViewModel {
    var bindableImage = Bindable<UIImage>()
    var bindableIsRegisterValid = Bindable<Bool>()
    var registerEmail: String? {
        didSet {
            registerMinimumTextValidation(name: registerName, email: registerEmail, password: registerPassword)}
    }
    var registerName: String? {
        didSet {
            registerMinimumTextValidation(name: registerName, email: registerEmail, password: registerPassword)}
    }
    var registerPassword: String? {
        didSet {
            registerMinimumTextValidation(name: registerName, email: registerEmail, password: registerPassword)}
    }
    fileprivate var isValid = false {
        didSet {
            bindableIsRegisterValid.value = isValid
        }
    }
    
    func performRegistration(completion:()->()) {
        guard
            let name = registerName,
            let email = registerEmail,
            let password = registerPassword,
            let image = bindableImage.value
            else {return}
        print("REGISTER => Name: \(name), Email: \(email), Password: \(password), profileImageSize: \(image.size)")
    }
    
    func isRegisterTextValid() -> Bool {
        return isValid
    }
    
    fileprivate func registerMinimumTextValidation(name: String?, email: String?, password: String?) {
        let nameCount = name?.count ?? 0
        let emailCount = email?.count ?? 0
        let passwordCount = password?.count ?? 0
        let result = nameCount > 0 && emailCount > 3 && passwordCount > 5
        isValid = result
    }
    
}
