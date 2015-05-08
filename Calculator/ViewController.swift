//
//  ViewController.swift
//  Calculator
//
//  Created by Pedro on 1/30/15.
//  Copyright (c) 2015 Gazeus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber = false
    var userAlreadyUseDot = false
    var operandStack = Array<Double>()

    
    @IBAction func appendDigit(sender: UIButton) {

        let digit = sender.currentTitle!
        append(digit)
    }
    
    @IBAction func operate(sender: UIButton) {
        if(userIsInTheMiddleOfTypingANumber) {
            enter()
        }
        
        let operation = sender.currentTitle!
        switch operation {
            case "×":
                performeOperation(*)
            case "÷":
                performeOperation {$1 / $0}
            case "−":
                performeOperation {$1 - $0}
            case "+":
                performeOperation { $1 + $0 }
            case "√":
                performeOperation(sqrt)
            case "sin":
                performeOperation(sin)
            case "cos":
                performeOperation(cos)
            default: break
        }
       
    }
    
    @IBAction func clear(sender: UIButton) {
        append("0")
        
        userIsInTheMiddleOfTypingANumber = false
        userAlreadyUseDot = false
        operandStack.removeAll()
    }
    
    func append(digit:String) {
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    
    func performeOperation(operation: (Double, Double) -> Double) {
        if(operandStack.count > 1) {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func performeOperation(operation: (Double) -> Double) {
        if(operandStack.count > 0) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    @IBAction func useDot(sender: UIButton) {
        if !userAlreadyUseDot {
            appendDigit(sender)
        }
        userAlreadyUseDot = true
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userAlreadyUseDot = false
        operandStack.append(displayValue)
        println("teste =  \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

