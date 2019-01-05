//
//  LoginViewModel.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit


class LoginViewModel {
//    weak var loginSigninView: LoginSigninView?
    var name = ""
    var email = ""
    var password = ""
    var retypePassword = ""
//    init(loginView: LoginSigninView) {
//
//    }
    
    func setRegistrationValue(name: String, email: String, password: String, retypePassword: String) {
        self.name = name
        self.email = email
        self.password = password
        self.retypePassword = retypePassword
    }
    
    func registerValidation() -> Bool {
        if name.count > 0, email.count > 3, password.count > 5, password == retypePassword {
            return true
        } else {return false}
    }
    
    func setLoginValue(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
//    @objc func handleLoginRegisterChange() {
//        // reference for ui objects
//        guard let loginSigninView = loginSigninView else {return}
//        let loginRegisterSegmentedControl = loginSigninView.loginRegisterSegmentedControl
//        let loginRegisterButton = loginSigninView.loginRegisterButton
//        let profileImageView = loginSigninView.profileImageView
//        let nameTextField = loginSigninView.nameTextField
//        let emailTextField = loginSigninView.emailTextField
//        let passwordTextField = loginSigninView.passwordTextField
//        let inputsContainerView = loginSigninView.inputsContainerView
//
//        // change title
//        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
//        loginRegisterButton.setTitle(title, for: UIControl.State())
//
//        //change icon image
//        profileImageView.image = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? #imageLiteral(resourceName: "logo") : #imageLiteral(resourceName: "plus_photo")
//
//        // change height of inputContainerView
//        loginSigninView.inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
//
//        // change height of nameTextField
//        loginSigninView.nameTextFieldHeightAnchor?.isActive = false
//        loginSigninView.nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
//        loginSigninView.nameTextFieldHeightAnchor?.isActive = true
//        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
//
//        loginSigninView.emailTextFieldHeightAnchor?.isActive = false
//        loginSigninView.emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
//        loginSigninView.emailTextFieldHeightAnchor?.isActive = true
//
//        loginSigninView.passwordTextFieldHeightAnchor?.isActive = false
//        loginSigninView.passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
//        loginSigninView.passwordTextFieldHeightAnchor?.isActive = true
//    }
}
