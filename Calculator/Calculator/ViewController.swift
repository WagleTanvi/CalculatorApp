 //
//  ViewController.swift
//  Calculator
//
//  Created by Tanvi Wagle on 9/14/17.
//  Copyright © 2017 Tanvi Wagle. All rights reserved.
//
// alt click means bring it up on the right
import UIKit

 class ViewController: UIViewController { // declaration of class
    // name of class : object the class inherits from
    // instance variable = properties
    
    @IBOutlet weak var display: UILabel! // instance variable
     var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        // circle and @ what this method is hooked up to.. what userface element is hooked up to
        // Parts of a swift method:
        // underbar ... no external because it is implciit in the name of the method
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        // only unwarpp when you use let
        // digit was a contsant because it is one value... if we do not change the digit then we use let
        //print("\(digit) was called")
    }
    

    //func drawHorizontalLine (from startX: Double, toEndX: Double, using color: UIColor){
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    } // computed property
    private  var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }


        // two names for paramters, external and internal
        // external arguments --> refernece it outside the method
        // internal arguments --> refernece it insid eteh argument
        
    //}
    

}

