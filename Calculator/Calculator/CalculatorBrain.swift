//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Tanvi Wagle on 9/28/17.
//  Copyright © 2017 Tanvi Wagle. All rights reserved.
//

import Foundation

func changeSign (operand: Double) -> Double{
    return -operand
}
/*func multiply (op1: Double, op2: Double)-> Double {
    return op1*op2
}*/
struct CalculatorBrain{ // struct is a first class citizen 
    // differnece  between class and struct is that class has inheritence 
    // classes live in heap and have ponters -- reference types
    // struct do not live in heap and copy them -- value types
    
    private var accumulator: Double?
    private enum Operation{
        case constant (Double) // associated value (like in optionals)
        case unaryOperation ((Double) -> Double) // a function that takes a double and returns a double
        case binaryOperation((Double,Double)-> Double)
        case equals
    }// data structure that has discriet values
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation(changeSign),
        "×" : Operation.binaryOperation({ $0 * $1}),
        "÷" : Operation.binaryOperation({ $0 / $1}),
        "+" : Operation.binaryOperation({ $0 - $1}),
        "−" : Operation.binaryOperation({ $0 - $1}),
        "=": Operation.equals
        // closure is a function embedded in the code
    ] // returns an optional of the value because there might not be a constant for it
    
    // free intializer that intiazlizes everything
    
    
    mutating func performOperation(_ symbol : String){
        if let operation = operations[symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation( let function):
                if (accumulator != nil){
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if (accumulator != nil){
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case.equals:
                performPendingBinaryOperation()
                
            }
        }

        /*
         switch symbol{
         case "π":
            //display.text = String(M_PI)
            accumulator = Double.pi
        case "√" :
            //let operand = Double(display.text!)!
            //display.text = String(s qrt(operand))
            if let operand = accumulator{
                accumulator = sqrt(operand)
            }
        default:
            break
            //crtl I to indent fix
        }*/
    }
    mutating private func performPendingBinaryOperation(){
        if pbo != nil && accumulator != nil{
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand,secondOperand)
        }
    }
    mutating func setOperand(_ operand: Double){
        accumulator = operand
        // it has to know your writing to accumulator so change to mutating
    }
    
    var result: Double? {
        get{
            return accumulator
            // cant unwrap it because the accumulator can be not set so it could cause an error
        }
    }
    
    

}


