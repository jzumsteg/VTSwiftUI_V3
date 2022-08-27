//
//  AllVerbSettingsGroup.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 9/18/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//

import Foundation
class AllVerbSettingsGroup: ObservableObject {
//    static let shared: AllVerbSettingsGroup = AllVerbSettingsGroup()

    @Published var allGroupArray: [SettingsType: OneVerbSettingGroup]
    

     init() {
         allGroupArray = Dictionary()
        allGroupArray[.simple] = OneVerbSettingGroup(type: .simple)
        allGroupArray[.compound] = OneVerbSettingGroup(type: .compound)
        allGroupArray[.type] = OneVerbSettingGroup(type: .type)
        allGroupArray[.ending] = OneVerbSettingGroup(type: .ending)
        allGroupArray[.person] = OneVerbSettingGroup(type: .person)
    }
    
    func getSettingArray(type:SettingsType) -> OneVerbSettingGroup {
        return allGroupArray[type]!
    }
    
    func setState(name: String, value: Bool, type: SettingsType) -> VerbState? {
        guard let group = allGroupArray[type] else {
            return nil
        }
        return group.setState(name: name.lowercased(), state: value)
        
    }
    
    func getState(name: String, type: SettingsType) ->Bool? {
        guard let group = allGroupArray[type] else {
            return false
        }
        return group.getState(name: name.lowercased())
    }
    
    func setState(name: String, state: Bool) -> VerbState? {
        // iterate through the dictionary. Will receive a non-nil response when the correct verbstate is updated, so break out then
        for (_, group) in allGroupArray {
            if let returnVS = group.setState(name: name.lowercased(), state: state) {
                return returnVS
            }
        }
        // nothing matched setting_name, so return false, indicating no value was set
        return nil
    }
    
    func getState(name: String) -> Bool? {
        for (_, group) in allGroupArray {
            if group.getState(name: name.lowercased()) != nil {
                return true
            }
        }
        return false
        
    }
    
    func getAllVerbStates() -> [String: VerbState] {
        var allVerbStates = [String:VerbState]()
        if allGroupArray[.simple] != nil {
            allVerbStates.merge(allGroupArray[.simple]!.verbStates) {(current,_) in current}
        }
        if allGroupArray[.compound] != nil {
            allVerbStates.merge(allGroupArray[.compound]!.verbStates) {(current,_) in current}
        }
        if allGroupArray[.type] != nil {
            allVerbStates.merge(allGroupArray[.type]!.verbStates) {(current,_) in current}
        }
        if allGroupArray[.ending] != nil {
            allVerbStates.merge(allGroupArray[.ending]!.verbStates) {(current,_) in current}
        }
        if allGroupArray[.person] != nil {
            allVerbStates.merge(allGroupArray[.person]!.verbStates) {(current,_) in current}
        }

        
        
        return allVerbStates
    }
    
    func printYourself() {
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
