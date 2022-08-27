//
//  VerbSettingGroup.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 9/18/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//
enum SettingsType: Int {
    case simple = 0
    case compound = 1
    case type = 2
    case ending = 3
    case person = 4
}
    
import Foundation

/* Holds a grouping of verb settings, such as simple tenses, compound tenses, etc.
 There will be a class to hold an array of VerbSettingGroups
 */

public class OneVerbSettingGroup: ObservableObject {
    var type: SettingsType
    var verbStates: [String:VerbState]
    var allVerbState: VerbState
    
    private init() {
        verbStates = Dictionary()
        allVerbState = VerbState()
        type = .simple
    }
    
    convenience init(type: SettingsType) {
        self.init()
        self.type = type
        populate()
    }
    
    private func setAllState() {
        var newState: Bool = true
        for (_, vs) in verbStates {
            if vs.verbState == false {
                newState = false
                break // jump out of the test loop
            }
        }
        allVerbState.verbState = newState
        UDefs.set(value: allVerbState.verbState, forKey: allVerbState.name)
    }
    
    private func setAllGroupStates() {
        for (_, vs ) in verbStates {
            vs.verbState = allVerbState.verbState
            UDefs.set(value: vs.verbState, forKey: vs.name)
        }
    }
    
    /* returns the value of an input verbstate name
        will return false if there is a nil value or non-existent verbstate
        don't know if that's right
 */
    
    func getState(name: String) -> Bool? {
        if name == allVerbState.name {
            return allVerbState.verbState
        }
        if let vs = verbStates[name] {
            return vs.verbState
        }
        else {
            return nil
        }
    }
    
    func getVerbState(name: String) -> VerbState? {
        if name == allVerbState.name {
            return allVerbState
        }
        if let vs = verbStates[name] {
            return vs
        }
        else {
            return nil
        }
    }
    
    func getAllVerbStates() -> [String:VerbState] {
        return verbStates
    }
    
    func setState(name: String, state: Bool) -> VerbState? {
        
        // TO-DO: this should save the state to JzUserDefaults
        if name == allVerbState.name {
            allVerbState.verbState = state
            
            // set the values of all the verbstates of this group to what was set for
            // the all verbstate
            setAllGroupStates()
            return allVerbState
        }
        guard let vs = verbStates[name] else {
            return nil
            }
        vs.verbState = state
        UDefs.set(value: state, forKey: vs.name)
        
        // set the all verb state, which may have chaged as a result of this verbstate set
        setAllState()
        return vs
    }
    
    private func populate() {
        let db = DB.shared.stateDb
        var nameStr = String()
        switch type {
        case .simple:
            nameStr = "simple"
        case .compound:
            nameStr = "compound"
        case .type:
            nameStr = "type"
        case .ending:
            nameStr = "ending"
        case .person:
            nameStr = "person"
        }
        
        // first, get the 'all' verbstate
        var sql = "SELECT * FROM verbsettings where setting_type = ? AND setting_subtype = 'all'";
        guard let rs = db.executeQuery(sql, withArgumentsIn: [nameStr]) else {
            Log.print("db.lastError(): \(db.lastError())")
            return
        }
        
        rs.next()
        allVerbState.name = rs.string(forColumn: "setting_name")?.lowercased() ?? "error"
        allVerbState.verbType = rs.string(forColumn: "setting_type") ?? "type"
        allVerbState.verbSubType = rs.string(forColumn: "setting_subtype") ?? "subtype"
        allVerbState.summary = rs.bool(forColumn: "summary")
        allVerbState.whereStr = rs.string(forColumn: "whereStr")
        
        // get the state from defaults. If there is no state for this verbstate i defaults,
        // use what's in the database
        if let state = UDefs.bool(forKey: allVerbState.name) {
            allVerbState.verbState = state
        }
        else { // there was no state i defaults
            allVerbState.verbState = rs.bool(forColumn: "setting_state")
        }


        sql = "SELECT * FROM verbsettings WHERE setting_type = ? AND setting_subtype = ?;"
        guard let rs2 = db.executeQuery(sql, withArgumentsIn: [nameStr, nameStr]) else {

            Log.print("db.lastError(): \(db.lastError())")
            return
        }
        
        while rs2.next() {
            let vs = VerbState()
            vs.name = rs2.string(forColumn: "setting_name")?.lowercased() ?? "error"
            vs.verbType = rs2.string(forColumn: "setting_type") ?? "type"
            vs.verbSubType = rs2.string(forColumn: "setting_subtype") ?? "subtype"
            vs.summary = rs2.bool(forColumn: "summary")
            vs.whereStr = rs2.string(forColumn: "whereStr")
            
            // get the state from defaults. If there is no state for this verbstate i defaults,
            // use what's in the database
            if let state = UDefs.bool(forKey: vs.name) {
                vs.verbState = state
            }
            else { // there was no state i defaults
                vs.verbState = rs2.bool(forColumn: "setting_state")
            }
            
            verbStates[vs.name] = vs
        }
        
        // update from userDefaults
        // if there is a userDefault, update verbstates with the state
        // otherwise, leave it alone
        for (_, vs) in verbStates {
            if let st = UDefs.bool(forKey: vs.name) {
                vs.verbState = st
            }
        }

        Log.print("end of populate")
    }
    
    func whereClause() -> String {
        var cl = ""
        var needOr = false
        
        for k in verbStates.keys {
            if let vs = verbStates[k] {
                if vs.verbState == true {
                    if needOr {
                        cl += " OR "
                    }
                    cl += vs.whereStr
                    needOr = true
                    }
                }
            }
        return cl
    }
    
    func printYourself() {
        Log.print("settings_type)")
        for (_, verbState) in verbStates {
            verbState.printYourself()
        }
    }
    
    
}
