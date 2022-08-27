//
//  TestViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/15/22.
//

import Foundation
class TestViewModel: ObservableObject {
    @Published var numVerbs: Int
    @Published var numRight: Int {
        didSet {
            Log.print("numRight: \(numRight)")
        }
    }
    @Published var numWrong: Int {
        didSet {
            Log.print("numWrong: \(numWrong)")
        }
    }
    @Published var testsCompleted: Int = 0
    @Published var testSeconds: Int
    @Published var elapsedSeconds: Int
    @Published var remainingSeconds: Int
    @Published var testsRemaining: Int = 0
    @Published var pctCorrect: String = String()
    @Published var testDone: Bool = false
    @Published var showAlert: Bool = false
    
    @Published var secsRemaingStr: String = ""
    @Published var testsRemainingStr: String = ""
    
    
    var verbGenerator = VerbGenerator.shared
    var testType: QuizType
    var timer: Timer
    var testEnv: TestEnvironment?
    var displayAnswer: String = "" {
        didSet {
            Log.print("displayAnswer: \(displayAnswer)")
        }
    }
    var displayTranslation: String = ""
    var displayVerb: Verb = Verb()
    
    init() {
        // change all these from defaults to values from UDefs
        numVerbs = UDefs.int(forKey: K.numberVerbs, withDefault: 10)
        numRight = 0
        numWrong = 0
        
        testSeconds = UDefs.int(forKey: K.quizSeconds, withDefault: 10)
        elapsedSeconds = 0
        remainingSeconds = 0
        let testTypeRawValue = UDefs.int32(forKey: K.quizType)
        if testTypeRawValue != nil {
            testType = QuizType(rawValue: testTypeRawValue!)!
        }
        else {
            testType = .timedSetVerbs
        }
        timer = Timer()
        testEnv = TestEnvironment()
    }
    
    func setup() {
        verbGenerator.getVerb()
        displayVerb = verbGenerator.displayVerb
        displayAnswer = ""
        numVerbs = UDefs.int(forKey: K.numberVerbs, withDefault: 10)
        numRight = 0
        numWrong = 0
        testsRemaining = numVerbs
        testSeconds = UDefs.int(forKey: K.quizSeconds, withDefault: 10)
        elapsedSeconds = 0
        remainingSeconds = testSeconds - elapsedSeconds
        let testTypeRawValue = UDefs.int32(forKey: K.quizType)
        if testTypeRawValue != nil {
            testType = QuizType(rawValue: testTypeRawValue!)!
        }
        else {
            testType = .timedSetVerbs
        }
        switch testType {
        case .timedSetVerbs:
            secsRemaingStr = String(testSeconds)
            testsRemainingStr = String(testsRemaining)
        case .timedNoSet:
            secsRemaingStr = String(testSeconds)
            testsRemainingStr = "N/A"

        case .untimed:
            secsRemaingStr = "N/A"
            testsRemainingStr = String(testsRemaining)

        }
        
//        testType = .timedNoSet
        testEnv = TestEnvironment()

    }
    
    func getVerb() -> Verb {
        verbGenerator.getVerb()
        displayVerb = verbGenerator.displayVerb
        displayAnswer = verbGenerator.displayVerb.answer
        displayTranslation = verbGenerator.displayVerb.translation
        return displayVerb
    }
    
    func getAnswer() {
        displayAnswer = displayVerb.answer
    }
    
    func startTest(){
        Log.methodEnter()
        testEnv!.showAlert = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        secsRemaingStr = String(remainingSeconds)
        testsRemainingStr = String(testsRemaining)
        setup()
    }
    
    func clickedRight() {
        numRight += 1
        testsCompleted = numRight + numWrong
        testsRemaining = numVerbs - testsCompleted
        testsRemainingStr = String(testsRemaining)
        switch testType {
        case .timedSetVerbs, .untimed:
            if testsRemaining <= 0 {
                stopTest()
            }
        case .timedNoSet:
            testsRemainingStr = "N/A"
            break
        } // switch
    }
    
    func clickedWrong() {
        numWrong += 1
        testsCompleted = numRight + numWrong
        testsRemaining = numVerbs - testsCompleted
        testsRemainingStr = String(testsRemaining)
        switch testType {
        case .timedSetVerbs, .untimed:
            if testsRemaining <= 0 {
                stopTest()
            }
        case .timedNoSet:
            testsRemainingStr = "N/A"
            break
        } //
        
    }
    
    
    @objc func fireTimer() {
        elapsedSeconds += 1
        remainingSeconds = testSeconds - elapsedSeconds
//        Log.print("Time remaining: \(remainingSeconds)")
        secsRemaingStr = String(remainingSeconds)
        switch testType {
        case .timedSetVerbs, .timedNoSet:
            if remainingSeconds <= 0 {
                stopTest()
            }
        case .untimed:
            secsRemaingStr = "N/A"
            break
        } //
    }
    func stopTest() {
        Log.methodEnter()
        timer.invalidate()
        testDone = true
        showAlert = true
        let x = (Double(numRight) / Double(testsCompleted))
        if testsCompleted > 0 {
            pctCorrect =  "= \(Int(x*100.0))%"
        }
        else {
            pctCorrect = "N/A"
        }

    }
    
    func saveToHistory() {
        Log.methodEnter()
        // open the database
        let db = DB.shared.historyDB  // this is the settings database
        // get the datetime into a string
        let now = Date()
        
        
        let dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat =  "yyyy-MM-dd h:mm:ss"
        
        
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        let dtStr = dateFmt.string(from: now)
        Log.print(dtStr)
        let sql = "INSERT INTO quizHistories (datetime, numTests, numRight) VALUES ('\(dtStr)', \(testsCompleted), \(numRight));"
        db.executeUpdate(sql, withArgumentsIn: [])
    }
}
