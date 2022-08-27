//
//  TenseNames.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 10/5/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//

import Foundation
class TenseNames {
    var tenseLocation: tense_location {
        didSet {
            Params.shared.tenseLocale = tenseLocation
        }
    }
    
    var tenseArray: [(default: String, alt: String)]
    var tenseDict: [Int32 : (default: String, alt1: String)]
    static let sharedInstance : TenseNames = {
        let instance = TenseNames()
        return instance
    }()
    
    private init( ) {
        // MARK: Local Variable
        // setup code

        tenseLocation = tense_location()  // create a tense_location property with the value that has been saved previously
        tenseArray = Array()
        tenseDict = Dictionary()
        populateTenseArray()
    }
    
    
    func getDefault(tenseNumber: Int32) -> String? {
        guard let tense = tenseDict[tenseNumber] else {
            return nil
        }
        return tense.default
    }
    
    func getAlt(tenseNumber: Int32) -> String? {
        guard let tense = tenseDict[tenseNumber] else {
            return nil
        }
        return tense.alt1

    }
    
    func getTenseStr(tenseNumber: Int32, tenseLocale: tense_location) -> String? {
        guard let tense = tenseDict[tenseNumber] else {
            return nil
        }
        switch tenseLocale {
        case .default_locale:
            return tense.default
        case .alternative_locale_1:
            return tense.alt1
        }
    }
    
    func populateTenseArray() {
        let db = DB.shared.stateDb
        let sql = "SELECT tenseNumber, setting_name, setting_name_alt FROM verbsettings WHERE tenseNumber > 0 ORDER BY tenseNumber;"
        
        guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
            Log.print("db.lastError: \(db.lastError())")
            return
        }

        while rs.next() {
            let def = rs.string(forColumn: "setting_name") ?? "got a nil for default"
            let alt = rs.string(forColumn: "setting_name_alt") ?? "got a nil for alt"
            let tenseNumber = rs.int(forColumn: "tenseNumber")
            
            tenseDict[tenseNumber] = (default: def, alt1: alt)
 
        }
        
    }
    
    func tenseNumber(tenseStr: String,tenseLocale: tense_location = .default_locale) -> Int32? {
        var retVal: Int32 = 0
        
        for (key, tenseStrings) in tenseDict {
            switch tenseLocale {
            case .default_locale:
                if tenseStrings.default.lowercased() == tenseStr.lowercased() {
                    retVal = key
                }
            case .alternative_locale_1:
                if tenseStrings.alt1.lowercased() == tenseStr.lowercased() {
                    retVal = key
                }
            }
        }
        if retVal == 0 { // means the string was never found
            return nil
        }

        return retVal
    
    } //     func tenseNumber(tenseStr: String,tenseLocale: tense_location = tense_location(rawValue: 1) ?? .default_locale) -> Int32? {


}
