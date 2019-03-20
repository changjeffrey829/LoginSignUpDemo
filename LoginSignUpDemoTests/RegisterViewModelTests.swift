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
        sut.RegisterName = "1"
        sut.RegisterEmail = "12123"
        sut.RegisterPassword = "123123"
        let result = sut.isRegisterTextValid()
        XCTAssert(result)
        tearDown()
    }
    
    func testUsernameFailRequirement() {
        setUp()
        sut.RegisterName = ""
        sut.RegisterEmail = "12123"
        sut.RegisterPassword = "123123"
        let result = sut.isRegisterTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
    
    func testEmailFailRequirement() {
        setUp()
        sut.RegisterName = "1"
        sut.RegisterEmail = ""
        sut.RegisterPassword = "123123"
        let result = sut.isRegisterTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
    
    func testPasswordFailRequirement() {
        setUp()
        sut.RegisterName = "1"
        sut.RegisterEmail = "12123"
        sut.RegisterPassword = ""
        let result = sut.isRegisterTextValid()
        XCTAssertFalse(result)
        tearDown()
    }
}
