//
//  RegisterViewModelTests.swift
//  LoginSignUpDemoTests
//
//  Created by Jeffrey Chang on 3/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import LoginSignUpDemo

class RegisterViewModelTests: XCTestCase {
    var sut: RegisterViewModel!
    
    override func setUp() {
        sut = RegisterViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testTextMeetRequirement() {
        setUp()
        sut.registerName = "1"
        sut.registerEmail = "12123"
        sut.registerPassword = "123123"
        let result = sut.isRegisterTextValid()
        XCTAssert(result)
        tearDown()
    }
    
    func testUsernameFailRequirement() {
        setUp()
        sut.registerName = ""
        sut.registerEmail = "12123"
        sut.registerPassword = "123123"
        let result = sut.isRegisterTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
    
    func testEmailFailRequirement() {
        setUp()
        sut.registerName = "1"
        sut.registerEmail = ""
        sut.registerPassword = "123123"
        let result = sut.isRegisterTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
    
    func testPasswordFailRequirement() {
        setUp()
        sut.registerName = "1"
        sut.registerEmail = "12123"
        sut.registerPassword = ""
        let result = sut.isRegisterTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
}
