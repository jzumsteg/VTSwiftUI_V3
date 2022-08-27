//
//  DrillViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/7/22.
//

import Foundation
import SwiftUI
class DrillViewModel: ObservableObject {
    @Published var drillSource: String?
    
    var historyStack = HistoryStack()
    
    init() {

    } // init
    
    func setup( _ environments: EnvironmentalObjects) {
        Log2.shared.print("Log2 test")
        updateDrillSource()
    }
    
    func translationToDisplay(verb: Verb, atAnswer: Bool) -> String {
        var retStr = String()
        var answerString = String()
        if Params.shared.translationWhat == .verbform {
            answerString = verb.translation
        }
        else {
            answerString = verb.english
        }
        switch Params.shared.translationWhen {
        case .atQuiz:
            retStr = answerString
        case .atAnswer:
            if atAnswer == false {
                retStr = ""
            }
            else {
                retStr = answerString
            }
        case .never:
            retStr = ""
        } // switch
        return  retStr

    }
        
    func updateDrillSource() {
        switch Params.shared.verbSelectMode {
        case .use_one_verb:
            if Params.shared.currentSelectedVerbListName != nil {
                drillSource = "Using \(Params.shared.currentSelectedSingleVerbInfinitive!)"
            } else {
                drillSource = "Something went wrong, currentSelectedVerbList Name = nil"
            }
        case .use_all_verbs:
            drillSource = "Using all verbs"
        case .use_verb_list:
            if Params.shared.currentSelectedVerbListName != nil {
                drillSource = "Using verb list \"\(Params.shared.currentSelectedVerbListName!)\""
            }
            else {
                drillSource = "Something went wrong, Params.shared.currentSelectedVerbListName = nil "
            }
        }

    }
    
    func addToStack(verb: Verb) {
        historyStack.addVerb(verb: verb)
    }
    
    func setStackPos(_ pos: Int) {
        historyStack.stackPos = pos
    }
}
