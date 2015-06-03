//
//  ViewController.swift
//  Tarea0202
//
//  Created by modelo on 02/06/15.
//  Copyright (c) 2015 modelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var display : UILabel!
    
    var userIsEnteringNumbers = false
    
    @IBAction func enterNumber (sender : UIButton) {
        let digit = sender.currentTitle!
        
        if userIsEnteringNumbers {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsEnteringNumbers = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter () {
        userIsEnteringNumbers = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue : Double {
        get {
            return NSNumberFormatter ().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            userIsEnteringNumbers = false
        }
    }
    
    @IBAction func clearScreen(sender: AnyObject) {
        displayValue = 0
        display.text = "0"
    }
    
    @IBAction func operate (sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsEnteringNumbers {
            enter()
        }
        
        switch operation {
            case "➕": performOperation {$1 + $0}
        
            case "➖": performOperation {$1 - $0}
            
            case "✖️": performOperation {$1 * $0}
            
            case "➗": performOperation {$1 / $0}
            
            case "✔️": performOperation2 {sqrt($0)}
            
            default: break
        }
    }
    
    func performOperation (operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation (operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2 (operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation (operandStack.removeLast())
            enter()
        }
    }
    
    func add (op1: Double, op2: Double) -> Double {
        return op1 + op2
    }
    
    func subsract (op1: Double, op2: Double) -> Double {
        return op1 - op2
    }
    
    func multiply (op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    func divide (op1: Double, op2: Double) -> Double {
        return op1 / op2
    }
}

