//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Nicolas Demange on 08/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    
    func testAdditionMethod_WhenCorrectCalculIsGiven_ShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.addition()
        calculator.tappedNumber(numberText: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 + 1 = 2")
    }
    
    func testSoustractionMethod_WhenCorrectCalculIsGiven_ShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.substraction()
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "2 - 2 = 0")
    }
    
    func testMultiplicationMethod_WhenCorrectCalculIsGiven_ShouldReturnCorrectResult() {
        //        calculator.tappedNumber(numberText: "4")
        //        calculator.multiplication()
        //        calculator.tappedNumber(numberText: "2")
        //        calculator.equal()
        //        XCTAssertEqual(calculator.calculText, "4 x 2 = 8")
    }
    
    func testDivisionMethod_WhenCorrectCalculIsGiven_ShouldReturnCorrectResult() {
        //        calculator.tappedNumber(numberText: "4")
        //        calculator.division()
        //        calculator.tappedNumber(numberText: "2")
        //        calculator.equal()
        //        XCTAssertEqual(calculator.calculText, "4 / 2 = 2")
    }
    
    func testClearMethod_WhenTappedOnACButton_ShouldReturnClear() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "AC")
        calculator.clear()
        XCTAssertEqual(calculator.calculText, "")
    }
    
    func testResult_WhenUserHasFinishHisCalcul_ShouldCalculTextReset() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addition()
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        calculator.tappedNumber(numberText: "1")
        XCTAssertEqual(calculator.calculText, "1")
    }
    
    func testError_WhenUserTappedDoublePlus_ShouldShowError() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addition()
        calculator.addition()
        XCTAssertEqual(calculator.calculText, "2 + ")
    }
    
    func testError_WhenUserTappedDoubleMinus_ShouldShowError() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.substraction()
        calculator.substraction()
        XCTAssertEqual(calculator.calculText, "2 - ")
    }
    
    func testError_WhenCalculTextIsEmpty_ShouldShowError() {
        let calculator = Calculator()
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "")
    }
    
    func testError_WhenUserTappedWrongExpression_ShouldShowError() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addition()
        calculator.substraction()
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "2 + ")
    }
}
