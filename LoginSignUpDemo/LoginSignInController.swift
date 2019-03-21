//
//  ViewController.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/21/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit
import Photos

class LoginSignInController: UIViewController, UITextFieldDelegate {
    
    let loginRegisterView = LoginRegisterView()
    let loginViewModel = LoginViewModel()
    let registerViewModel = RegisterViewModel()
    
    //MARK:- APP LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configLoginRegisterView()
        TapScreenToHideKeyboard()
        canUserTapButton(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            canUserTapButton(loginViewModel.isLoginTextValid())
        } else {
            canUserTapButton(registerViewModel.isRegisterTextValid())
        }
    }
    
    //MARK:- CONFIGURATION
    fileprivate func configLoginRegisterView() {
        configButtons()
        configLoginContainerView()
        configRegisterContainerView()
        view = loginRegisterView
        
    }
    
    fileprivate func canUserTapButton(_ isFormValid: Bool) {
        if isFormValid {
            loginRegisterView.loginRegisterButton.isEnabled = true
            loginRegisterView.loginRegisterButton.backgroundColor = .customDarkBrown
        } else {
            loginRegisterView.loginRegisterButton.isEnabled = false
            loginRegisterView.loginRegisterButton.backgroundColor = .tabBarBrown
        }
    }
    
    fileprivate func configButtons() {
        let tapProfileGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        loginRegisterView.profileImageView.addGestureRecognizer(tapProfileGesture)
        loginRegisterView.loginRegisterSegmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        loginRegisterView.loginRegisterButton.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        loginRegisterView.forgetPasswordButton.addTarget(self, action: #selector(launchForgetPasswordVC), for: .touchUpInside)
    }
    
    fileprivate func configLoginContainerView() {
        loginViewModel.bindableIsLoginValid.bind { [unowned self] (isValid) in
            let isValid = isValid ?? false
            self.canUserTapButton(isValid)
        }
        loginRegisterView.loginContainerView.emailTextField.addTarget(self, action: #selector(handleLoginTextChanged), for: .editingChanged)
        loginRegisterView.loginContainerView.passwordTextField.addTarget(self, action: #selector(handleLoginTextChanged), for: .editingChanged)
        
    }
    
    fileprivate func configRegisterContainerView() {
        registerViewModel.bindableIsRegisterValid.bind { [unowned self] (isValid) in
            let isValid = isValid ?? false
            self.canUserTapButton(isValid)
        }
        registerViewModel.bindableImage.bind { [unowned self] (image) in
            self.loginRegisterView.profileImageView.image = image
        }
        loginRegisterView.registerContainerView.nameTextField.addTarget(self, action: #selector(handleRegisterTextChanged), for: .editingChanged)
        loginRegisterView.registerContainerView.emailTextField.addTarget(self, action: #selector(handleRegisterTextChanged), for: .editingChanged)
        loginRegisterView.registerContainerView.passwordTextField.addTarget(self, action: #selector(handleRegisterTextChanged), for: .editingChanged)
    }
    
    //MARK:- ANIMATION
    fileprivate func transitingToLogin() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: loginRegisterView.registerContainerView, duration: 0.3, options: transitionOptions, animations: { [unowned self] in
            self.loginRegisterView.loginContainerView.isHidden = false
            self.loginRegisterView.profileImageView.image = #imageLiteral(resourceName: "logo")
            self.loginRegisterView.profileImageView.isUserInteractionEnabled = false
        })
        UIView.transition(with: loginRegisterView.loginContainerView, duration: 0.3, options: transitionOptions, animations: nil) { [unowned self] (_) in
            self.loginRegisterView.registerContainerView.isHidden = true
            self.loginRegisterView.bringSubviewToFront(self.loginRegisterView.registerContainerView)
        }
    }

    fileprivate func transitingToRegister() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(with: loginRegisterView.loginContainerView, duration: 0.3, options: transitionOptions, animations: { [unowned self] in
            self.loginRegisterView.registerContainerView.isHidden = false
            self.loginRegisterView.profileImageView.image = #imageLiteral(resourceName: "plus_photo")
            self.loginRegisterView.profileImageView.isUserInteractionEnabled = true
        })
        UIView.transition(with: loginRegisterView.registerContainerView, duration: 0.3, options: transitionOptions, animations: nil) { [unowned self] (_) in
            self.loginRegisterView.loginContainerView.isHidden = true
            self.loginRegisterView.bringSubviewToFront(self.loginRegisterView.loginContainerView)
        }
    }
    
    //MARK:- BUTTONS
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterView.loginRegisterSegmentedControl.titleForSegment(at: loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterView.loginRegisterButton.setTitle(title, for: UIControl.State())
        
        if loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            transitingToLogin()
            canUserTapButton(loginViewModel.isLoginTextValid())
        } else {
            transitingToRegister()
            canUserTapButton(registerViewModel.isRegisterTextValid())
        }
    }
    
    @objc func handleLoginRegister() {
        if loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            loginViewModel.performLogin {
            }
        } else {
            registerViewModel.performRegistration {
            }
        }
    }
    
    @objc private func launchForgetPasswordVC() {
        print("launch reset pw vc")
        
    }
    
    //MARK:- KEYBOARD & TEXTFIELD
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleLoginRegister()
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    fileprivate func TapScreenToHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(keyboardHide))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func handleLoginTextChanged(textfield: UITextField) {
        let loginView = loginRegisterView.loginContainerView
        if textfield == loginView.emailTextField  {
            loginViewModel.loginEmail = loginView.emailTextField.text
        } else {
            loginViewModel.loginPassword = loginView.passwordTextField.text
        }
    }
    
    @objc fileprivate func handleRegisterTextChanged(textfield: UITextField) {
        let registerView = loginRegisterView.registerContainerView
        if textfield == registerView.nameTextField  {
            registerViewModel.registerName = registerView.nameTextField.text
        } else if textfield == registerView.emailTextField {
            registerViewModel.registerEmail = registerView.emailTextField.text
        } else {
            registerViewModel.registerPassword = registerView.passwordTextField.text
        }
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.endEditing(true)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension LoginSignInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- HANDLE PROFILE IMAGE
    @objc func handleSelectProfileImageView() {
        authorizeToAlbum { [unowned self] (status) in
            if status == true {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    func authorizeToAlbum(completion:@escaping (Bool)->Void) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        completion(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
        } else {
            DispatchQueue.main.async(execute: {
                completion(true)
            })
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        registerViewModel.bindableImage.value = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
