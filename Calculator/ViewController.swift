//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Correia de Barros on 7/13/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate var userIsTyping = false
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping{
            let currentText = display.text!
			display.text = digit == "." && currentText.range(of: digit) != nil ? currentText : currentText + digit
        } else{
            display.text = digit
        }
        userIsTyping = true
    }
    
    fileprivate var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        let mathSymbol = sender.currentTitle!
        brain.performOperation(mathSymbol)
        displayValue = brain.result
    }
}

