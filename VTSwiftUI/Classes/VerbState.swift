//
//  VerbState.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/16/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation

class VerbState: ObservableObject {
    var name: String
    var altName: String
    var verbType: String
    var verbSubType: String
    @Published var verbState: Bool {
        didSet {
            UDefs.set(value: verbState, forKey: name)
        }
    }
    var viewRow: Int32
    var tenseNumber: Int32
    var summary: Bool
    var whereStr: String!
    
    init() {
        name = ""
        altName = ""
        verbType = ""
        verbSubType = ""
        verbState = false
        viewRow = 0
        tenseNumber = 0
        summary = false
    }
    
    convenience init(name: String, type: String, subType: String, state: Bool, row: Int32) {
        self.init()
        self.name = name
        verbType = type
        verbSubType = subType
        verbState = state
        viewRow = row
    }
    
    func isOn() -> Bool {
        return self.verbState
    }
    
    func isSimple() -> Bool {
        return verbSubType == "simple" ? true : false
    }
    
    func isCompound() -> Bool {
        return verbSubType == "compound" ? true : false
    }
    
    func saveStateInUserDefaults() {
        UDefs.set(value: verbState, forKey: name)
    }
    
    func getStateFromUserDefaults() {
        if let tmpVal = UDefs.bool(forKey: name) {
            verbState = tmpVal
        }
        else {
            verbState = false
        }
    }
    
    /** 
     Saves this verbstate in an NSArray, suitable for saving to an NSData structure
     */
    func saveForICloud() -> NSArray {
        let arr = NSMutableArray()
        arr.add(name)
        arr.add(verbType)
        arr.add(verbSubType)
        arr.add(tenseNumber)
        arr.add(NSNumber(value: verbState as Bool))
        arr.add(NSNumber(value: viewRow as Int32))
        return arr
        
        
    }
    
    func printYourself() {
        Log.print("verbState:")
        Log.print("    name: \(name)")
        Log.print("    altName: \(altName)")
        Log.print("    verbType: \(verbType)")
        Log.print("    verbSubType: \(verbSubType)")
        let stateStr = verbState ? "On" : "Off"
        Log.print("    state: \(stateStr)")
        Log.print("    tenseNumber: \(tenseNumber)")
        Log.print("    viewRow: \(viewRow)")
        Log.print("    summary: \(summary)")
        
    }
}
