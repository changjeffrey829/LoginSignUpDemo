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
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.customDarkBrown
        button.setTitle("Login", for: UIControl.State())
        button.setTitleColor(UIColor.customOrange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.delegate = self
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    lazy var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot your password?", for: .normal)
        button.setTitleColor(UIColor.customOrange, for: .normal)
        button.addTarget(self, action: #selector(launchForgetPasswordVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = true
        setUpViews()
        TapScreenToHideKeyboard()
    }
    
    @objc private func launchForgetPasswordVC() {
        print("launch reset pw vc")
//        let vc = ResetPasswordViewController()
//        present(vc, animated: true, completion: nil)
    }
    
    func finishedRegistration() {
//        UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
//        FSService.shared.fetchCurrentUserFromFirestore { (_) in
//        }
//        dismiss(animated: true, completion: nil)
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
    
    //MARK: setup functions
    fileprivate func setUpViews() {
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(forgetPasswordButton)
        //profileImageView
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        
        //loginRegisterSegmentedControl
        loginRegisterSegmentedControl.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
        
        setupContainerView()
        
        //loginRegisterButton
        loginRegisterButton.anchor(top: inputsContainerView.bottomAnchor, left: loginRegisterSegmentedControl.leftAnchor, bottom: nil, right: loginRegisterSegmentedControl.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    fileprivate func setupContainerView() {
        inputsContainerView.autoresizesSubviews = false
        print(inputsContainerView.autoresizesSubviews)
        
        inputsContainerView.anchor(top: loginRegisterSegmentedControl.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 150)
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //nameTextField
        nameTextField.anchor(top: inputsContainerView.topAnchor, left: inputsContainerView.leftAnchor, bottom: nil, right: inputsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
        nameTextFieldHeightAnchor?.isActive = true
        
        //separator line
        nameSeparatorView.anchor(top: nameTextField.bottomAnchor, left: inputsContainerView.leftAnchor, bottom: nil, right: inputsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        // emailTextField
        emailTextField.anchor(top: nameTextField.bottomAnchor, left: nameTextField.leftAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
        emailTextFieldHeightAnchor?.isActive = true
        
        //separator line
        emailSeparatorView.anchor(top: emailTextField.bottomAnchor, left: inputsContainerView.leftAnchor, bottom: nil, right: inputsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        //passwordTextField
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: nameTextField.leftAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
        
        //forgetpassword button
        forgetPasswordButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        forgetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: objc functions
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegistration()
        }
    }
    
    private func handleLogin() {
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
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
        guard
            let name = nameTextField.text,
            let email = emailTextField.text?.lowercased(),
            let password = passwordTextField.text,
            let profileImage = profileImageView.image
            else {return}
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            editedImage.withRenderingMode(.alwaysOriginal)
            profileImageView.image = editedImage
        } else if let originalImage =
            info["UIImagePickerControllerOriginalImage"] as? UIImage {
            originalImage.withRenderingMode(.alwaysOriginal)
            profileImageView.image = originalImage
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        picker.dismiss(animated: true, completion: nil)
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
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        if isFormValid {
            loginRegisterButton.isEnabled = true
            loginRegisterButton.backgroundColor = .customDarkBrown
        } else {
            loginRegisterButton.isEnabled = false
            loginRegisterButton.backgroundColor = UIColor.tabBarBrown
        }
    }
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControl.State())
        
        //change icon image
        profileImageView.image = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? #imageLiteral(resourceName: "logo") : #imageLiteral(resourceName: "plus_photo")
        
        // change height of inputContainerView,
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}


