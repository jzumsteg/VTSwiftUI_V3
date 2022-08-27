//
//  TestSettingsViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/17/22.
//
//case timedSetVerbs = 0
//case timedNoSet = 1
//case untimed = 2


import Foundation
class TestSettingsViewModel:ObservableObject {
    @Published var quizType: QuizType = .timedSetVerbs {
        didSet {
            let rv = quizType.rawValue
            UDefs.set(value: rv, forKey: K.quizType)
        }
    }
    @Published var numVerbsStr: String = ""
    {
        didSet {
            Log.print("numVerbStr: '\(numVerbsStr)'")
            if numVerbsStr != "" {
                let nmVerbs = Int(numVerbsStr)!
                if nmVerbs == 0 {
                    numVerbs = 5
                }
                else {
                    numVerbs = nmVerbs
                }
            }
            else {
                numVerbs = 5
            }
            UDefs.set(value: numVerbs, forKey: K.numberVerbs)
        }
    }
    
    @Published var numMinutesStr: String = "" {
        didSet {
            Log.print("Changed numMinutesStr to \(numMinutesStr)")
//            saveQuizDuration()
        }
    }
    @Published var numSecondsStr: String = "" {
        didSet {
            Log.print("Changed numSecondsStr to \(numSecondsStr)")
//            saveQuizDuration()
        }
    }
    
    @Published var retestCorrect: Bool = false
    @Published var translationHint: Bool = false
    
    var quizDuration: Int = 30
    
    var duration: Int = 30
    var numVerbs: Int = 10
    
//    init() {
////        quizType = .timedSetVerbs
//
//    }
    
    func setup() {
        let quizTypeRaw = UDefs.int(forKey: K.quizType, withDefault: 0)
        quizType = QuizType(rawValue: Int32(quizTypeRaw))!
        numVerbsStr = String(UDefs.int(forKey: K.numberVerbs, withDefault: 10))
        duration = UDefs.int(forKey: K.quizSeconds, withDefault: 30)
        let result = minSecs(duration: duration)
        numSecondsStr = String(result.1)
        numMinutesStr = String(result.0)
        
    }
    
    func calcQuizDuration() {
        let minutes = Int(numMinutesStr)!
        let seconds = Int(numSecondsStr)!
        duration = (minutes * 60) + seconds
        UDefs.set(value: duration, forKey: K.quizSeconds)
        Log.print("quizDuration in seconds: \(duration)")
        
    }
    func minSecs(duration: Int) -> (minutes: Int,  seconds:Int) {
        let minutes = Int(duration / 60 )
        let seconds = duration % 60
        return (minutes, seconds)
    }
    
    func saveQuizDuration () {
        let numMinutes = Int(numMinutesStr) ?? 0
        let numSeconds = Int(numSecondsStr) ?? 0
        let duration = (numMinutes * 60) + numSeconds
//        let durationStr = String(duration)
        UDefs.set(value: duration, forKey: K.quizSeconds)
    }
    
}
