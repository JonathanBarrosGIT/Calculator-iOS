//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jonathan Correia de Barros on 7/15/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    fileprivate var accumulator = 0.0
    
    var result: Double {
        get{
            return accumulator
        }
    }
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    fileprivate enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    fileprivate var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(M_PI),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({ -$0}),
        "×" : Operation.binaryOperation({$0 * $1}), // == {(op1: Double, op2: Double) -> Double in return op1 * op2 }
        "+" : Operation.binaryOperation({$0 + $1}),
        "−" : Operation.binaryOperation({$0 - $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "=" : Operation.equals
    ]
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator)
            case .binaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand:accumulator)
            case .equals:
                executePendingBinaryOperation()
                
            }
        }
    }
    
    fileprivate var pending: PendingBinaryOperationInfo?
    
    fileprivate func executePendingBinaryOperation() {
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    fileprivate struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
}
