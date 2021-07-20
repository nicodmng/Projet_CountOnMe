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
        // décompose les caractères et ne compte pas le caractère " " dans la ligne de texte
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "x" && elements.last != "/"

    }
//    var divisionError: Bool {
//        return elements.last != ""
//    }
    // Minimum 3 caractères avant de lancer le calcul
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "x" && elements.last != "/"
    }
    
    // Find a "=" in the calcul text.
    var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }

    //MARK: - Methods
//    func error() {
//        if divisionError {
//            calculText.append("0")
//        } else {
//            delegate?.showError(text: "ErrorCalcul")
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
            delegate?.showError(text: "Un opérateur est déjà mis !")
        }
    }
    
    func division() {
        if canAddOperator {
            calculText.append(" / ")
        } else {
            delegate?.showError(text: "Un opérateur est déjà mis !")
        }
    }
    
    func calculPriority(elements: [String]) -> [String] {
        var tempElements = elements

        while tempElements.contains("x") || tempElements.contains("/") {
            if let operatorIndex = tempElements.firstIndex(where: { $0 == "x" || $0 == "/"}) {
                let mathOperator = tempElements[operatorIndex]
                guard let leftNumber = Double(tempElements[operatorIndex - 1]) else { return [] }
                guard let rightNumber = Double(tempElements[operatorIndex + 1]) else { return [] }
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
        
//        while (tempElements.firstIndex(of: "x") != nil) || (tempElements.firstIndex(of: "/") != nil) {
//
//            // recherche du premier indice d'un opérateur prioritaire
//            var firstIndex = 0
//            if let multIndex = tempElements.firstIndex(of: "x"),
//               let divIndex = tempElements.firstIndex(of: "/") {
//            firstIndex = min(multIndex, divIndex)
//            } else if let multIndex = tempElements.firstIndex(of: "x") {
//                firstIndex = multIndex
//            } else if let divIndex = tempElements.firstIndex(of: "/") {
//                firstIndex = divIndex
//            }
//
//            // chercher les éléments gauche et droite de l'opérateur
//            let left = Double(elements[firstIndex - 1])!
//            let operand = elements[firstIndex]
//            let right = Double(elements[firstIndex + 1])!
//
//            // réalisation du calcul
//            let result: Double
//            switch operand {
//            case "x": result = left * right
//            case "/": result = left / right
//            default : continue
//            }
//
//            // suppression de l'index du milieu (opérateur) et l'index de droite (l'operand) puis remplacer l'index de gauche par le résultat
//            tempElements.remove(at: firstIndex)
//            tempElements.remove(at: firstIndex)
//            tempElements[firstIndex - 1] = "\(result)"
//        }
        return tempElements
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
