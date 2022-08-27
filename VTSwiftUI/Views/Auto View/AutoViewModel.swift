//
//  AutoViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/30/22.
//

enum DisplayMode {
    case quizShowing
    case answerShowing
}

import Foundation
import SwiftUI
class AutoViewModel: ObservableObject {
    var verbgen: VerbGenerator?
    @Published var displayVerb = Verb()
    @Published var displayAnswer = String()
    @Published var displayTranslation = String()
    @Published var displayMode: DisplayMode = .quizShowing
        
    @Published var answerTimer = Timer()
    @Published var drillTimer = Timer()
    
    @Published var timeRemaining: Int32 = 0
    
    var tempAnswer = String()
    var tempVerb = Verb()
    
    var drillSeconds: Int32 = 0 {
        didSet {
            UDefs.set(value: drillSeconds, forKey: K.keyAutoSettingQuizDuration)
        }
    }
    var answerSeconds: Int32 = 0 {
        didSet {
            UDefs.set(value: answerSeconds, forKey: K.keyAutoSettingAnswerDuration)
        }
    }
    
    func setup(verbGenerator: VerbGenerator) {
        Log.methodEnter()
//        let p = Params.shared
        if Params.shared.selectedTab == "auto" {
            self.verbgen = verbGenerator
            drillSeconds = Params.shared.drillDuration
            answerSeconds = Params.shared.answerDuration
            timeRemaining = drillSeconds - answerSeconds
        }
         
    }
    
    init() {
        Log.methodEnter()
        drillSeconds = Params.shared.drillDuration
        answerSeconds = Params.shared.answerDuration


    }
    
    
    @objc func newVerb() {
        Log.methodEnter()
        if Params.shared.selectedTab == "auto" {
            answerTimer.invalidate()
            drillTimer = Timer.scheduledTimer(timeInterval: Double(drillSeconds), target: self, selector: #selector(showAnswer), userInfo: nil, repeats: false)
            verbgen!.getVerb()
            displayVerb = verbgen!.displayVerb
    //        tempAnswer = displayVerb.answer
    //        displayVerb.answer = ""
            displayAnswer = ""
            displayTranslation = ""
            displayMode = .quizShowing
        }
        else {
            answerTimer.invalidate()
            drillTimer.invalidate()
        }

    }
    
    @objc func showAnswer() {
        Log.methodEnter()
            if Params.shared.selectedTab == "auto" {
                drillTimer.invalidate()
                answerTimer = Timer.scheduledTimer(timeInterval: Double(answerSeconds), target: self, selector: #selector(newVerb), userInfo: nil, repeats: true)
                displayMode = .answerShowing
                displayAnswer = displayVerb.answer
                displayTranslation = displayVerb.translation
            } else {
                answerTimer.invalidate()
                drillTimer.invalidate()
            }
            
        }
    
    func invalidateTimers() {
        Log.methodEnter()
        answerTimer.invalidate()
        drillTimer.invalidate()
    }
}
