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
        sut.LoginEmail = "123123"
        sut.LoginPassword = "123123"
        let result = sut.isLoginTextValid()
        XCTAssert(result)
        tearDown()
    }
    
    func testEmailFailRequirement() {
        setUp()
        sut.LoginEmail = "13"
        sut.LoginPassword = "123123"
        let result = sut.isLoginTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
    
    func testPasswordFailRequirement() {
        setUp()
        sut.LoginEmail = "12123"
        sut.LoginPassword = "1"
        let result = sut.isLoginTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
}
