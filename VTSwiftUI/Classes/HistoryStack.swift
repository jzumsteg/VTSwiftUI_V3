//
//  HistoryStack.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 1/16/15.
//  Copyright (c) 2015 verbtrainers. All rights reserved.
//

import Foundation

class HistoryStack: ObservableObject {
    @Published var stack: Array<Verb>
    var stackPos: Int
    
    init() {
        stack = Array()
        stackPos = 0
    }

    func addVerb(verb: Verb) {
        if stack.count == 50 {
            stack.removeLast()
        }
        stack.insert(verb, at: 0)
    }
    
    func getFirstVerb() -> Verb {
        stackPos = stack.count - 1
        return stack[stackPos]
    }
    
    func goBackOne() -> Verb {
        if stackPos == stack.count - 1 {
            stackPos = 0
        }
        else {
            stackPos += 1
        }
        return stack[stackPos]
    }
    
    func goForwardOne() -> Verb {
        if stackPos == 0 {
            stackPos = stack.count - 1
        }
        else {
            stackPos -= 1
        }
        return stack[stackPos]
    }
    
    func canGoForward() -> Bool {
        if stack.count > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func canGoBackward() -> Bool {
        if stack.count > 0 {
            return true
        }
        else {
            return false
        }
        
    }
    
    func print() {
        Log.print("Stack -- stackPos: \(stackPos)")
        for v in stack {
            Log.print("\(v.infinitive); \(v.tense); \(v.number)")
        }
    }
}
