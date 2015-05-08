//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by pcortez on 5/8/15.
//  Copyright (c) 2015 Gazeus. All rights reserved.
//

import Foundation


class CalculatorBrain
{
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double) -> Double)
    }
    
    private var opStack = [Op]()
    private var knownOps = Dictionary<String, Op>()
    
    
    init() {
        knownOps["×"]   = Op.BinaryOperation("×" , *)
        knownOps["÷"]   = Op.BinaryOperation("÷" , { $1 / $0 })
        knownOps["−"]   = Op.BinaryOperation("−" , { $1 - $0 })
        knownOps["+"]   = Op.BinaryOperation("+" , +)
        knownOps["√"]   = Op.UnaryOperation("√"  , sqrt)
        knownOps["sin"] = Op.UnaryOperation("sin", sin)
        knownOps["cos"] = Op.UnaryOperation("√"  , cos)
        
        
        
    } 
    
    func pushOperand(operand:Double) {
        opStack.append(Op.Operand(operand))
    }

    func performOperation(symbol:String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}

