//
//  LoginSignUpDemoTests.swift
//  LoginSignUpDemoTests
//
//  Created by Jeffrey Chang on 3/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import LoginSignUpDemo

class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!
    
    override func setUp() {
        sut = LoginViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testTextMeetRequirement() {
        setUp()
        sut.loginEmail = "123123"
        sut.loginPassword = "123123"
        let result = sut.isLoginTextValid()
        XCTAssert(result)
        tearDown()
    }
    
    func testEmailFailRequirement() {
        setUp()
        sut.loginEmail = "13"
        sut.loginPassword = "123123"
        let result = sut.isLoginTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
    
    func testPasswordFailRequirement() {
        setUp()
        sut.loginEmail = "12123"
        sut.loginPassword = "1"
        let result = sut.isLoginTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
}
