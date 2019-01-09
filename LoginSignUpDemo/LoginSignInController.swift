//
//  ViewController.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/21/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit
import Photos

class LoginSignInController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let loginSigninView = LoginSigninView()
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        config()
        TapScreenToHideKeyboard()
    }
    
    fileprivate func config() {
        loginSigninView.profileImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        loginSigninView.loginRegisterSegmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
        configLoginContainerView()
        configRegisterContainerView()
        loginSigninView.loginRegisterButton.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        loginSigninView.forgetPasswordButton.addTarget(self, action: #selector(launchForgetPasswordVC), for: .touchUpInside)
        view = loginSigninView
    }
    
    fileprivate func configLoginContainerView() {
        loginSigninView.loginContainerView.emailTextField.addTarget(self, action: #selector(handleValidateLoginText), for: .editingChanged)
        loginSigninView.loginContainerView.passwordTextField.addTarget(self, action: #selector(handleValidateLoginText), for: .editingChanged)
    }
    
    fileprivate func configRegisterContainerView() {
        loginSigninView.registerContainerView.nameTextField.addTarget(self, action: #selector(handleValidateRegisterText), for: .editingChanged)
        loginSigninView.registerContainerView.emailTextField.addTarget(self, action: #selector(handleValidateRegisterText), for: .editingChanged)
        loginSigninView.registerContainerView.passwordTextField.addTarget(self, action: #selector(handleValidateRegisterText), for: .editingChanged)
    }
    
    @objc func handleLoginRegisterChange() {
        
        // change title
        let title = loginSigninView.loginRegisterSegmentedControl.titleForSegment(at: loginSigninView.loginRegisterSegmentedControl.selectedSegmentIndex)
        loginSigninView.loginRegisterButton.setTitle(title, for: UIControl.State())
        
        if loginSigninView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            transitingToLogin()
            handleValidateLoginText()
        } else {
            transitingToRegister()
            handleValidateRegisterText()
        }
        
        
        
//        // reference for ui objects
//        let loginRegisterSegmentedControl = loginSigninView.loginRegisterSegmentedControl
//        let loginRegisterButton = loginSigninView.loginRegisterButton
//        let profileImageView = loginSigninView.profileImageView
//
//        // change title
//        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
//        loginRegisterButton.setTitle(title, for: UIControl.State())
//
//        //change icon image
//        profileImageView.image = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? #imageLiteral(resourceName: "logo") : #imageLiteral(resourceName: "plus_photo")
    }
    
    fileprivate func transitingToLogin() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: loginSigninView.registerContainerView, duration: 0.3, options: transitionOptions, animations: {
            self.loginSigninView.loginContainerView.isHidden = false
        })
        UIView.transition(with: loginSigninView.loginContainerView, duration: 0.3, options: transitionOptions, animations: nil) { (_) in
            self.loginSigninView.registerContainerView.isHidden = true
            self.loginSigninView.bringSubviewToFront(self.loginSigninView.registerContainerView)
        }
    }
    
    fileprivate func transitingToRegister() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(with: loginSigninView.loginContainerView, duration: 0.3, options: transitionOptions, animations: {
            self.loginSigninView.registerContainerView.isHidden = false
        })
        UIView.transition(with: loginSigninView.registerContainerView, duration: 0.3, options: transitionOptions, animations: nil) { (_) in
            self.loginSigninView.loginContainerView.isHidden = true
            self.loginSigninView.bringSubviewToFront(self.loginSigninView.loginContainerView)
        }
    }
    
    @objc private func launchForgetPasswordVC() {
        print("launch reset pw vc")
        
    }
    
    func finishedRegistration() {
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleLoginRegister()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.placeholder == "Password" {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
            view.layoutIfNeeded()
        }
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
    
    //MARK: objc functions
    @objc func handleLoginRegister() {
        print("handleLoginRegister")
//        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
//            handleLogin()
//        } else {
//            handleRegistration()
//        }
    }
    
    private func handleLogin() {
//        guard let email = emailTextField.text?.lowercased() else {return}
//        guard let password = passwordTextField.text else {return}
//        FSService.shared.loginAccount(email: email, password: password, completion: { (uid, err) in
//            if err != nil {
//                let alert = self.invalidInputAlert()
//                self.present(alert, animated: true, completion: nil)
//            }
//            UserManager.share.updateCurrentUserFromFSService(completion: { (user) in
//                guard let user = user else {return}
//                FSService.shared.checkIfFCMTokenNeedUpdate(user: user, completion: { (err) in
//                    if let err = err{
//                        print(err.localizedDescription)
//                    }
//                })
//
//                if user.partnerUID != "" {
//                    HistoryManager.share.fetchHistory(uid: user.uid)
//                    QuestManager.share.fetchAllData(currentUser: user)
//                    ItemManager.share.fetchAllData(currentUser: user)
//                } else if user.isInvisible == false {
//                    InviteRequestManager.share.loadAcceptedInviteFromSever(uid: user.uid)
//                }
//            })
//            DispatchQueue.main.async {
//                self.finishedRegistration()
//            }
//        })
    }
    
    private func handleRegistration() {
//        guard
//            let name = nameTextField.text,
//            let email = emailTextField.text?.lowercased(),
//            let password = passwordTextField.text,
//            let profileImage = profileImageView.image
//            else {return}
//        UserManager.share.createNewUser(withEmail: email, name: name, password: password, image: profileImage) { (status) in
//            if status == true {
//                DispatchQueue.main.async {
//                    self.finishedRegistration()
//                }
//            }
//        }
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.endEditing(true)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func handleSelectProfileImageView() {
        print("handleSelectProfileImageView")
//        authorizeToAlbum { (status) in
//            if status == true {
//                let imagePickerController = UIImagePickerController()
//                imagePickerController.sourceType = .photoLibrary
//                imagePickerController.delegate = self
//                imagePickerController.allowsEditing = true
//                self.present(imagePickerController, animated: true, completion: nil)
//            }
//        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            editedImage.withRenderingMode(.alwaysOriginal)
//            profileImageView.image = editedImage
//        } else if let originalImage =
//            info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            originalImage.withRenderingMode(.alwaysOriginal)
//            profileImageView.image = originalImage
//        }
//        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
//        profileImageView.layer.masksToBounds = true
//        picker.dismiss(animated: true, completion: nil)
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
    
    @objc func handleValidateLoginText() {
        let email = loginSigninView.loginContainerView.emailTextField.text ?? ""
        let password = loginSigninView.loginContainerView.passwordTextField.text ?? ""
        let isFormValid = viewModel.loginMinimumWordValidation(email: email, password: password)
        if isFormValid {
            loginSigninView.loginRegisterButton.isEnabled = true
            loginSigninView.loginRegisterButton.backgroundColor = .customDarkBrown
        } else {
            loginSigninView.loginRegisterButton.isEnabled = false
            loginSigninView.loginRegisterButton.backgroundColor = .tabBarBrown
        }
    }
    
    @objc func handleValidateRegisterText() {
        let name = loginSigninView.registerContainerView.nameTextField.text ?? ""
        let email = loginSigninView.registerContainerView.emailTextField.text ?? ""
        let password = loginSigninView.registerContainerView.passwordTextField.text ?? ""
        let isFormValid = viewModel.registerMinimumWordValidation(name: name, email: email, password: password)
        if isFormValid {
            loginSigninView.loginRegisterButton.isEnabled = true
            loginSigninView.loginRegisterButton.backgroundColor = .customDarkBrown
        } else {
            loginSigninView.loginRegisterButton.isEnabled = false
            loginSigninView.loginRegisterButton.backgroundColor = .tabBarBrown
        }
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}


