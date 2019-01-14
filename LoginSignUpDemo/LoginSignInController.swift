//
//  ViewController.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/21/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit
import Photos

class LoginSignInController: UIViewController, UITextFieldDelegate, TextValidation {
    
    let loginRegisterView = LoginRegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        configLoginRegisterView()
        TapScreenToHideKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleValidateLoginText()
        } else {
            handleValidateRegisterText()
        }
    }
    //MARK: ----------------------------------------------------------
    
    //MARK: CONFIGURATION: LoginRegisterView
    fileprivate func configLoginRegisterView() {
        configButtons()
        configLoginContainerView()
        configRegisterContainerView()
        view = loginRegisterView
    }
    
    fileprivate func configButtons() {
        let tapProfileGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        loginRegisterView.profileImageView.addGestureRecognizer(tapProfileGesture)
        loginRegisterView.loginRegisterSegmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        loginRegisterView.loginRegisterButton.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        loginRegisterView.forgetPasswordButton.addTarget(self, action: #selector(launchForgetPasswordVC), for: .touchUpInside)
    }
    
    fileprivate func configLoginContainerView() {
        loginRegisterView.loginContainerView.emailTextField.addTarget(self, action: #selector(handleValidateLoginText), for: .editingChanged)
        loginRegisterView.loginContainerView.passwordTextField.addTarget(self, action: #selector(handleValidateLoginText), for: .editingChanged)
    }
    
    fileprivate func configRegisterContainerView() {
        loginRegisterView.registerContainerView.nameTextField.addTarget(self, action: #selector(handleValidateRegisterText), for: .editingChanged)
        loginRegisterView.registerContainerView.emailTextField.addTarget(self, action: #selector(handleValidateRegisterText), for: .editingChanged)
        loginRegisterView.registerContainerView.passwordTextField.addTarget(self, action: #selector(handleValidateRegisterText), for: .editingChanged)
    }
    //MARK: ----------------------------------------------------------
    
    //MARK: ANIMATION
    fileprivate func transitingToLogin() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: loginRegisterView.registerContainerView, duration: 0.3, options: transitionOptions, animations: {
            self.loginRegisterView.loginContainerView.isHidden = false
            self.loginRegisterView.profileImageView.image = #imageLiteral(resourceName: "logo")
            self.loginRegisterView.profileImageView.isUserInteractionEnabled = false
        })
        UIView.transition(with: loginRegisterView.loginContainerView, duration: 0.3, options: transitionOptions, animations: nil) { (_) in
            self.loginRegisterView.registerContainerView.isHidden = true
            self.loginRegisterView.bringSubviewToFront(self.loginRegisterView.registerContainerView)
        }
    }
    
    fileprivate func transitingToRegister() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(with: loginRegisterView.loginContainerView, duration: 0.3, options: transitionOptions, animations: {
            self.loginRegisterView.registerContainerView.isHidden = false
            self.loginRegisterView.profileImageView.image = #imageLiteral(resourceName: "plus_photo")
            self.loginRegisterView.profileImageView.isUserInteractionEnabled = true
        })
        UIView.transition(with: loginRegisterView.registerContainerView, duration: 0.3, options: transitionOptions, animations: nil) { (_) in
            self.loginRegisterView.loginContainerView.isHidden = true
            self.loginRegisterView.bringSubviewToFront(self.loginRegisterView.loginContainerView)
        }
    }
    //MARK: ----------------------------------------------------------
    
    //MARK: Login, Register, and forget password
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterView.loginRegisterSegmentedControl.titleForSegment(at: loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterView.loginRegisterButton.setTitle(title, for: UIControl.State())
        
        if loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            transitingToLogin()
            handleValidateLoginText()
        } else {
            transitingToRegister()
            handleValidateRegisterText()
        }
    }
    
    @objc func handleLoginRegister() {
        if loginRegisterView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegistration()
        }
    }
    
    fileprivate func handleLogin() {
        guard
            let email = loginRegisterView.loginContainerView.emailTextField.text?.lowercased(),
            let password = loginRegisterView.loginContainerView.passwordTextField.text?.lowercased()
            else {return}
        print("LOGIN => Email: \(email), Password: \(password)")
    }
    
    fileprivate func handleRegistration() {
        guard
            let name = loginRegisterView.registerContainerView.nameTextField.text,
            let email = loginRegisterView.registerContainerView.emailTextField.text,
            let password = loginRegisterView.registerContainerView.passwordTextField.text,
            let image = loginRegisterView.profileImageView.image
            else {return}
        print("REGISTER => Name: \(name), Email: \(email), Password: \(password), profileImageSize: \(image.size)")
    }
    
    @objc private func launchForgetPasswordVC() {
        print("launch reset pw vc")
        
    }
    //MARK: ----------------------------------------------------------
    
    //MARK: Keyboard and Textfield
    
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
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.endEditing(true)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    //MARK: ----------------------------------------------------------
    
    //MARK: Text Input Validation
    @objc func handleValidateLoginText() {
        let email = loginRegisterView.loginContainerView.emailTextField.text ?? ""
        let password = loginRegisterView.loginContainerView.passwordTextField.text ?? ""
        let isFormValid = loginMinimumTextValidation(email: email, password: password)
        if isFormValid {
            loginRegisterView.loginRegisterButton.isEnabled = true
            loginRegisterView.loginRegisterButton.backgroundColor = .customDarkBrown
        } else {
            loginRegisterView.loginRegisterButton.isEnabled = false
            loginRegisterView.loginRegisterButton.backgroundColor = .tabBarBrown
        }
    }
    
    @objc func handleValidateRegisterText() {
        let name = loginRegisterView.registerContainerView.nameTextField.text ?? ""
        let email = loginRegisterView.registerContainerView.emailTextField.text ?? ""
        let password = loginRegisterView.registerContainerView.passwordTextField.text ?? ""
        let isFormValid = registerMinimumTextValidation(name: name, email: email, password: password)
        if isFormValid {
            loginRegisterView.loginRegisterButton.isEnabled = true
            loginRegisterView.loginRegisterButton.backgroundColor = .customDarkBrown
        } else {
            loginRegisterView.loginRegisterButton.isEnabled = false
            loginRegisterView.loginRegisterButton.backgroundColor = .tabBarBrown
        }
    }
}

extension LoginSignInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Handle picking profile image
    @objc func handleSelectProfileImageView() {
        authorizeToAlbum { (status) in
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
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        loginRegisterView.profileImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
