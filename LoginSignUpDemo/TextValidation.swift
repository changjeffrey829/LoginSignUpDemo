//
//  LoginViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

protocol TextValidation {
    func loginMinimumTextValidation(email: String, password: String) -> Bool
    func registerMinimumTextValidation(name: String, email: String, password: String) -> Bool
}

extension TextValidation {
    func loginMinimumTextValidation(email: String, password: String) -> Bool {
        return email.count > 3 && password.count > 5
    }
    func registerMinimumTextValidation(name: String, email: String, password: String) -> Bool {
        return name.count > 0 && email.count > 3 && password.count > 5
    }
}


