//
//  Model.swift
//  CountOnMe
//
//  Created by Nicolas Demange on 11/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

//MARK: - Protocol
protocol Display {
    func showCalcul(text: String)
    func showError(text: String)
}

class Calculator {
    //MARK: - Var
    var delegate: Display?

    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        //formatter.usesSignificantDigits = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var calculText: String = "" {
        didSet {
            delegate?.showCalcul(text: calculText)
        }
    }
    
    var elements: [String] {
        // décompose les caractères et ne compte pas le caractère " " dans la ligne de texte
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "x" && elements.last != "/"
    }

    // Minimum 3 caractères avant de lancer le calcul
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var isDivisionByZero: Bool {
        return calculText.contains("/ 0")
    }
            
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "x" && elements.last != "/"
            && !elements.isEmpty
    }
    
    // Find a "=" in the calcul text.
    var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }

    //MARK: - Methods

    func addAnOperator(operatorSign: String) {
        if canAddOperator {
            calculText.append(operatorSign)
        } else {
            delegate?.showError(text: "Vous ne pouvez pas saisir un opérateur")
        }
    }
    
    func calculPriority(elements: [String]) -> [String] {
        var tempElements = elements
        while tempElements.contains("x") || tempElements.contains("/") {
            if let operatorIndex = tempElements.firstIndex(where: { $0 == "x" || $0 == "/"}) {
                let mathOperator = tempElements[operatorIndex]
                
                guard let leftNumber = Double(tempElements[operatorIndex - 1]) else {
                    return []
                }
                guard let rightNumber = Double(tempElements[operatorIndex + 1]) else {
                    return []
                }
                let result: Double
                if mathOperator == "x" {
                    result = leftNumber * rightNumber
                } else {
                    result = leftNumber / rightNumber
                }
                tempElements[operatorIndex - 1] = String(result)
                tempElements.remove(at: operatorIndex + 1)
                tempElements.remove(at: operatorIndex)
            }
        }
        return tempElements
        }
    
    func equal() {
        guard expressionIsCorrect else {
            delegate?.showError(text: "Entrez une expression correcte")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.showError(text: "Démarrez un nouveau calcul")
            return
        }

        guard !isDivisionByZero else {
            delegate?.showError(text: "La division par zéro est impossible")
            return
        }
        
        var operationsToReduce = calculPriority(elements: elements)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            let result: Double
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default : return
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        guard let result = operationsToReduce.first else { return }
        guard let double = Double(result) else { return }
        guard let numFormat = numberFormatter.string(from: NSNumber(value: double)) else { return }
       calculText.append(" = " + numFormat)
    }
    
    func tappedNumber(numberText: String) {
        if expressionHaveResult {
            calculText = ""
        }
        calculText.append(numberText)
    }
    
    func clear() {
        calculText.removeAll()
    }
}

