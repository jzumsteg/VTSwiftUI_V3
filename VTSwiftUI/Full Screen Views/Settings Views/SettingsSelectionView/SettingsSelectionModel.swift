//
//  SettingsSelectionModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 12/2/21.
//

import Foundation

class SettingsSelectionModel: ObservableObject {
    @Published var verbCount: Int32 = 10
    var verbGenerator = VerbGenerator.shared
    
    
    init() {
        verbCount = 10
        Log.print("init'ing")
    }
    
    func setup() {
        verbCount = verbGenerator.calculateRecordCount()
    }
    
    func getVerbCount() -> Int32 {
        verbCount = verbGenerator.calculateRecordCount()
        return  verbCount
    }
    func validate()  {
        
    }
}


