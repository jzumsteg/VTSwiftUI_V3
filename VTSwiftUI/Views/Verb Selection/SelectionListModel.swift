//
//  TenseSelectionListKodel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/20/21.
//

import Foundation
import SwiftUI

class SelectionRowModel: ObservableObject {
    @Published var vs: VerbState
        
    init(verbState: VerbState) {
        self.vs = verbState
    }
}

struct SelectionRow: View {
//    var rowName: String
    @ObservedObject var slm: SelectionRowModel
//    @Binding var tenseState: Bool
    var settings = AllVerbSettingsGroup()

    var body: some View {
        Toggle(slm.vs.name, isOn: $slm.vs.verbState.didSet {(state) in
            print("New value is: \(state)")
            _ = settings.setState(setting_name: slm.vs.name, state: state)
        })
    } // varbody:someView:25
}

class SelectionListModel: ObservableObject {
    
    @Published var simpleStates: [String : VerbState] = [:]
    @Published var compoundStates: [String : Bool] = [:]
    @Published var typeStates: [String : Bool] = [:]
    @Published var endingStates: [String : Bool] = [:]
    @Published var personStates: [String : Bool] = [:]
    
    var selection = AllVerbSettingsGroup()
    init() {
        simpleStates = getSimple()
        compoundStates = getCompound()
    }

    func getSimple() -> [SelectionRowModel] {
        var returnArray = [SelectionRowModel]()
//        return selection.getSimpleStates()
        kSimpleTenses.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name.lowercased()) ?? true
//            returnArray.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
            returnArray[name] = state
        }
        return returnArray
    }
    func getCompound() -> [String : Bool ]{
        var returnArray = [String : Bool]()
        kCompoundTenses.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name.lowercased()) ?? true
//            returnArray.append( SelectionRowModel(id: 0, settingName: name, settingState: state))
            returnArray[name] = state
      }
        return returnArray
    }

    func getEndings() -> [String : Bool ] {
        var returnArray = [String : Bool]()
        kEndings.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name.lowercased()) ?? true
            returnArray[name] = state
       }
        return returnArray
    }
    
    func getTypes() -> [String : Bool ] {
        var returnArray = [String : Bool]()
        kTypes.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name.lowercased()) ?? true
            returnArray[name] = state
       }
        return returnArray
    }

    func getPersons() -> [String : Bool ] {
        var returnArray = [String : Bool]()
        kPersons.forEach { row in
            let name = row
            let state = JzUserDefaults.bool(forKey: name.lowercased()) ?? true
            returnArray[name] = state
       }
        return returnArray
    }

    
    func setSimpleState(vs:VerbState) {
        _ = selection.setState(setting_name: vs.name, state: vs.verbState)
        simpleStates[vs.name] = vs
    }

    func setCompoundState(name: String, state: Bool) {
        _ = selection.setState(setting_name: name, state: state)
        compoundStates[name] = state
    }

    
}
