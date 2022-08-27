//
//  SelectDrillSourceodel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/23/22.
//

import Foundation

class SelectDrillSourceModel: ObservableObject {
    var environmentals: EnvironmentalObjects?
    var selectMode: Quiz_selection_mode = Params.shared.verbSelectMode {
        willSet {
            objectWillChange.send()
            Log.print("Object will change to \(newValue)")
            Params.shared.verbSelectMode = newValue
        }
    }
    var selectedSingleVerb: String {
            willSet {
                objectWillChange.send()
                Log.print("Object will change to \(newValue)")
                Params.shared.currentSelectedSingleVerbInfinitive = newValue
            }
    }
    @Published var selectedVerbList : Verblist? = Params.shared.currentSelectedVerblist ?? Verblist() {
        didSet {
            guard let val = selectedVerbList  else {return}
            Params.shared.currentSelectedVerblist = val
            Params.shared.currentSelectedVerbListName = val.name
        }
    }
    
    init() {
        selectedSingleVerb = ""
    }
    
    func setup(_ env: EnvironmentalObjects) {
        Log2.shared.print("test")
        self.environmentals = env
        if let val = Params.shared.currentSelectedSingleVerbInfinitive {
            selectedSingleVerb = val
        }
        else {
            selectedSingleVerb = ""
        }
        
        if let val = Params.shared.currentSelectedVerblist {
            selectedVerbList = val
        }
        else {
            selectedVerbList = nil
        }
        
        Log2.shared.print("Done")
    }
}
