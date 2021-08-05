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
        calculator.addAnOperator(operatorSign: " + ")
        calculator.tappedNumber(numberText: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 + 1 = 2")
    }
    
    func testSoustractionMethod_WhenCorrectCalculIsGiven_ShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " - ")
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "2 - 2 = 0")
    }
    
    func testPriorityCalcul_WhenUserMakeAMultiplication_ShouldMultiplicatorFirst() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " + ")
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " x ")
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "2 + 2 x 2 = 6")
    }
    
    func testPriorityCalcul_WhenUserMakeADivision_ShouldDivisionFirst() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " + ")
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " / ")
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "2 + 2 / 2 = 3")
    }
    
    func testClear_WhenUserTappedClearButton_ShouldResetCalcul() {
        let calculator = Calculator()
        calculator.clear()
        XCTAssertEqual(calculator.calculText, "")
    }
    
    func testShowError_WhenUserTappedDoubleOperator_ShouldReturnMessageError() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " + ")
        calculator.addAnOperator(operatorSign: " + ")
        }
    
    func testExpressionIsCorrect_WhenUserTappedAWrongCalcul_ShouldReturnMessageError() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "25")
        calculator.addAnOperator(operatorSign: " + ")
        calculator.equal()
    }
    
    func testExpressionHaveEnoughElement_WhenUserDontTappedACalcul_ShouldReturnMessageError() {
        let calculator = Calculator()
        calculator.equal()
    }
    
    func testDivisionByZero_WhenUserMakeADivisionByZero_ShouldReturnMessageError() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "10")
        calculator.addAnOperator(operatorSign: " / ")
        calculator.tappedNumber(numberText: "0")
        calculator.equal()
    }
    
    func testNextCalcul_WhenUserMakeACalculDirectly_ShouldReturnEmptyCalculText() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "10")
        calculator.addAnOperator(operatorSign: " / ")
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        calculator.tappedNumber(numberText: "3")
    }
    
    func testSimpleMultiplication_WhenUserMakeAMultiplication_ShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "10")
        calculator.addAnOperator(operatorSign: " x ")
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " + ")
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "10 x 2 + 2 = 22")
    }
    
    func testSimpleDivision_WhenUserMakeADivision_ShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "10")
        calculator.addAnOperator(operatorSign: " / ")
        calculator.tappedNumber(numberText: "2")
        calculator.addAnOperator(operatorSign: " + ")
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "10 / 2 + 2 = 7")
    }
}
