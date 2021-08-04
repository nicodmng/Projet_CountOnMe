//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let calculator = Calculator()
    
    //MARK: - IBOutlets & IBActions
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.tappedNumber(numberText: numberText)
    }

    @IBAction func tappedOperatorButton(_ sender: AnyObject) {
        guard let operatorButton = sender as? UIButton else {
            return
        }
        
        switch operatorButton.tag {
        case 0 :
            calculator.addAnOperator(operatorSign: " + ")
        case 1 :
            calculator.addAnOperator(operatorSign: " - ")
        case 2 :
            calculator.addAnOperator(operatorSign: " x ")
        case 3 :
            calculator.addAnOperator(operatorSign: " / ")
        default :
            return
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.equal()
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.clear()
        textView.text = "0"
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
}

//MARK: - Extensions
extension ViewController: Display {
    func showCalcul(text: String) {
        textView.text = text
    }
    
    func showError(text: String) {
        let alertVC = UIAlertController(title: "Attention !", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


