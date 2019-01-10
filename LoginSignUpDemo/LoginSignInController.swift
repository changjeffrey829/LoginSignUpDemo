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

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

extension LoginSignInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
