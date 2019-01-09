//
//  LoginViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit


class LoginViewModel {
    
    func loginMinimumWordValidation(email: String, password: String) -> Bool {
        return email.count > 3 && password.count > 5
    }
    
    func registerMinimumWordValidation(name: String, email: String, password: String) -> Bool {
        return name.count > 0 && email.count > 3 && password.count > 5
    }
}
