//
//  AllVerbSettingsGroup.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 9/18/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//

import Foundation
class AllVerbSettingsGroup {
    var allGroupArray: [settings_type: OneVerbSettingGroup]
    
    
    init() {
        allGroupArray = Dictionary()
        allGroupArray[.simple] = OneVerbSettingGroup(type: .simple)
        allGroupArray[.compound] = OneVerbSettingGroup(type: .compound)
        allGroupArray[.type] = OneVerbSettingGroup(type: .type)
        allGroupArray[.ending] = OneVerbSettingGroup(type: .ending)
        allGroupArray[.person] = OneVerbSettingGroup(type: .person)
    }
    
    func setState(name: String, value: Bool, type: settings_type) -> VerbState? {
        guard let group = allGroupArray[type] else {
            return nil
        }
        return group.setState(setting_name: name.lowercased(), state: value)
        
    }
    
    func getState(name: String, type: settings_type) ->Bool? {
        guard let group = allGroupArray[type] else {
            return false
        }
        return group.getState(setting_name: name.lowercased())
    }
    
    func setState(setting_name: String, state: Bool) -> VerbState? {
        // iterate through the dictionary. Will receive a non-nil response when the correct verbstate is updated, so break out then
        for (_, group) in allGroupArray {
            if let returnVS = group.setState(setting_name: setting_name, state: state) {
                return returnVS
            }
        }
        // nothing matched setting_name, so return false, indicating no value was set
        return nil
    }
    
    func getState(setting_name: String) -> Bool? {
        for (_, group) in allGroupArray {
            if group.getState(setting_name: setting_name) != nil {
                return true
            }
        }
        return false
        
    }
    
//    func getAllVerbStates() -> [VerbState] {
//        var vsArray = [VerbState]()
//        for (_, group) in allGroupArray {
//            let oneGroupVerbstates = group.getVerbStates()
//            for (_ , vs) in oneGroupVerbstates {
//                vsArray.append(vs)
//            }
//
//            return vsArray
//        }
    func print() {
        for (_, group) in allGroupArray {
            group.printYourself()
        }
    }
}

extension AllVerbSettingsGroup {
    func whereClause() -> String {
        var wClause = String()
        var needAnd = false
        
        let simpleGroup = allGroupArray[.simple]!
        let simpleWhereClause = simpleGroup.whereClause()
        
        let compoundGroup = allGroupArray[.compound]!
        let compoundWhereClause = compoundGroup.whereClause()
        
        if (simpleWhereClause.count) > 0 && (compoundWhereClause.count) > 0 {
            wClause = simpleWhereClause + " OR " + compoundWhereClause
            needAnd = true
        }
        else {
            wClause = simpleWhereClause + compoundWhereClause // one of these will be empty
            needAnd = true
        }
        
        for (_, group) in allGroupArray {
            if group.type != .simple && group.type != .compound { // already doen those}
                let grWhereClause = group.whereClause()
                if wClause.count > 0 {
                    if needAnd {
                        wClause += ") AND ("
                    }
                    wClause += grWhereClause
                    needAnd = true
                }
            }
        }
        
        if wClause.count > 0 {
            wClause = " WHERE (" + wClause + ")"
        }
        
        
    return wClause
    }
}
