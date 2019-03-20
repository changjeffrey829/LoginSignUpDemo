//
//  LoginSigninView.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/26/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

class LoginRegisterView: UIView {
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.brown
        setUpViews()
    }
    
    fileprivate func setupContainerView() {
        
        //forgetpassword button
        forgetPasswordButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        forgetPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    
    fileprivate func setUpViews() {
        addSubview(profileImageView)
        addSubview(loginRegisterSegmentedControl)
        addSubview(loginRegisterButton)
        addSubview(forgetPasswordButton)
        addSubview(loginContainerView)
        addSubview(registerContainerView)
        
        
        //profileImageView
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        
        loginRegisterSegmentedControl.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
        
        registerContainerView.anchor(top: loginRegisterSegmentedControl.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 150)
        registerContainerView.isHidden = true
        
        loginContainerView.anchor(top: loginRegisterSegmentedControl.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 150)
        
        loginRegisterButton.anchor(top: registerContainerView.bottomAnchor, left: loginRegisterSegmentedControl.leftAnchor, bottom: nil, right: loginRegisterSegmentedControl.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        forgetPasswordButton.anchor(top: loginRegisterButton.bottomAnchor, left: loginRegisterButton.leftAnchor, bottom: nil, right: loginRegisterButton.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    let loginContainerView: LoginContainerView = {
        let view = LoginContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let registerContainerView: RegisterContainerView = {
        let view = RegisterContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.tabBarBrown
        button.setTitle("Login", for: UIControl.State())
        button.setTitleColor(UIColor.customOrange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.isUserInteractionEnabled = true
        return imageView
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
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
