//
//  AppDelegate.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/21/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = LoginSignInController(loginViewModel: LoginViewModel(), registerViewModel: RegisterViewModel())
        return true
    }
}

