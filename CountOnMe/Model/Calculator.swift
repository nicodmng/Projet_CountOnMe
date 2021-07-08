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
    
    var calculText: String = "" {
        didSet {
            delegate?.showCalcul(text: calculText)
        }
    }
    
    var elements: [String] {
        // décompose les caractères et compte le caractère " " dans la ligne de texte
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"

    }
    
    // Minimum 3 caractères avant de lancer le calcul
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    // Find a "=" in the calcul text.
    var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    
    //MARK: - Methodes
//    func test() {
//        if elements.isEmpty == true {
//            calculText = "0"
//        }
//    }
    
    func addition() {
        if canAddOperator {
            calculText.append(" + ")
        } else {
            delegate?.showError(text: "Un opérateur est déjà mis !")
        }
    }
    
    func substraction() {
        if canAddOperator {
            calculText.append(" - ")
        } else {
            delegate?.showError(text: "Un opérateur est déjà mis !")
        }
    }
    
    func multiplication() {
        if canAddOperator {
            calculText.append(" x ")
        } else {
            
        }
    }
    
    func division() {
        if canAddOperator {
            calculText.append(" / ")
        } else {
            
        }
    }
    
    func equal() {
        guard expressionIsCorrect else {
            delegate?.showError(text: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.showError(text: "Démarrez un nouveau calcul !")
            return
        }
        
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        calculText.append(" = \(operationsToReduce.first!)")
    }
    
    func clear() {
        calculText.removeAll()
    }
    
    func tappedNumber(numberText: String) {
        if expressionHaveResult {
            calculText = ""
        }
        calculText.append(numberText)
    }
    
    // Create local copy of operations
    
}
