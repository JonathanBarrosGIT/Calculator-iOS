//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Correia de Barros on 7/13/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsTyping = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping{
            let currentText = display.text!
            display.text = currentText + digit
        } else{
            display.text = digit
        }
        userIsTyping = true
    }
    
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        let mathSymbol = sender.currentTitle!
        brain.performOperation(mathSymbol)
        displayValue = brain.result
    }
}

