//
//  VerbGeneratorModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 3/1/22.
//

import Foundation
class VerbGeneratorModel: ObservableObject {
    @Published var displayVerb: Verb?
    @Published var answer: String?
    
    var verbGen = VerbGenerator.shared
    
    func setup() {
        verbGen.getVerb()
        displayVerb = verbGen.displayVerb
    }
    
    func getVerb() {
        verbGen.getVerb()
        displayVerb = verbGen.displayVerb
    }
    
    func getAnswer() {
        
    }
}
