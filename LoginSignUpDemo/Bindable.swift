//
//  Bindable.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 3/21/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
