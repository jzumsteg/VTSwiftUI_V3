//
//  TenseSelectionListKodel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/20/21.
//

import Foundation
import SwiftUI

struct SelectionRowModel {
    var id: Int
    var settingName: String
    var settingState: Bool
}
class SelectionListModel {
    
    var simpleStates = [SelectionRowModel]()
    var compoundStates = [SelectionRowModel]()
    var typeStates = [SelectionRowModel]()
    var endingStates = [SelectionRowModel]()
    var personStates = [SelectionRowModel]()

    func getSimple() -> [SelectionRowModel] {
        var returnArray = [SelectionRowModel]()
        kSimpleTenses.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name) ?? true
            returnArray.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
        }
        return returnArray
    }
    func getCompound() {
        kCompoundTenses.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name) ?? true
            compoundStates.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
        }
    }
    func getEndings() {
        kEndings.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name) ?? true
            endingStates.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
        }
    }
    func getTypes() {
        kTypes.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name) ?? true
            typeStates.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
        }
    }
    func getPersons() {
        kPersons.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name) ?? true
            personStates.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
        }
    }


    
}
