//
//  Params.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 7/17/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//
// initialize each parameter in init()
// each parameter has a willSet that looks to see if the newvalue is not nil. If it is notnil, save it using JzDefaults
// if it is nil, do nothing with it.
// the value will be nil, but the default will not be.
// should never set one of these variables to nil, but it could be nil if it has never been set in the app.
import Foundation
import CoreData
import UniformTypeIdentifiers
class Params: ObservableObject {
    static let shared: Params = Params()
    
    var translationWhen: Translation_when {
        didSet {
            UDefs.set(value: translationWhen.rawValue, forKey: K.keyTranslationWhen)
        }
    }
    
    var translationWhat: Translation_what {
        didSet {
            UDefs.set(value: translationWhat.rawValue, forKey: K.keyTranslationWhat)
        }
    }
    
    var infinitiveDisplay: Infinitive_list_display {
        didSet {
            UDefs.set(value: infinitiveDisplay.rawValue, forKey: K.keyInfinitiveDisplay )
        }
    }
    
    var drillDuration: Int32 {
        didSet {
            Log.print("DrillDuration: \(drillDuration)")
            UDefs.set(value: drillDuration, forKey: K.keyAutoSettingQuizDuration)
        }
    }
    
    var answerDuration: Int32 {
        didSet {
            Log.print("answerDuration: \(answerDuration)")
            UDefs.set(value: answerDuration, forKey: K.keyAutoSettingAnswerDuration)
        }
    }
    
    var selectedTab: String {
        didSet {
            UDefs.set(value: selectedTab, forKey: K.keySelectedTab)
            Log.print("In Params, setting selectedTab: \(selectedTab)")

        }
    }
    
    var currentSelectedVerbListName: String?  {
        didSet {
            if let val = currentSelectedVerbListName {
                UDefs.set(value: val, forKey: K.keyVerbListSelectedName)
            }
            else {
             currentSelectedVerbListName = nil
            }
        }
    }
    
    var showPronounWithAnswer: Bool = true {
        didSet {
            UDefs.set(value: showPronounWithAnswer, forKey: K.keyPronounDisplay)
        }
    }
    
    var currentSelectedVerblist: Verblist?
    
    var currentSearchStr: String {
        didSet {
            UDefs.set(value: currentSearchStr, forKey: K.keySearchStr)
        }

    }
    
    var tenseLocale: tense_location {
        didSet {
            UDefs.set(value: tenseLocale.rawValue, forKey: K.keyTenseLocale)
        }
    }

    var currentSelectedSingleVerbInfinitive: String? {
        didSet {
            if let val = currentSelectedSingleVerbInfinitive  {
                UDefs.set(value: val, forKey: K.keySingleVerbSelected)
            }
        }
    }
    
     var verbSelectMode: Quiz_selection_mode {
        didSet {
            let val: Int32 = verbSelectMode.rawValue
            UDefs.set(value: val, forKey: K.keyQuizSelectionMode)
        }
    }
    

    
    private init() {
        verbSelectMode = Quiz_selection_mode(rawValue: UDefs.int32(forKey: K.keyQuizSelectionMode, withDefault: 0))!
        infinitiveDisplay = Infinitive_list_display(rawValue: UDefs.int32(forKey: K.keyInfinitiveDisplay, withDefault: 0))!
        translationWhen = Translation_when(rawValue: UDefs.int32(forKey: K.keyTranslationWhen, withDefault: 0))!
        translationWhat = Translation_what(rawValue: UDefs.int32(forKey: K.keyTranslationWhat, withDefault: 0))!

        if UDefs.defaultExists(forKey: K.keyVerbListSelectedName) {
            let vlName = UDefs.string(forKey: K.keyVerbListSelectedName)
            let vlPath = FileUtilities.verbListDirectoryPath().stringByAppendingPathComponent(path: vlName!).stringByAppendingPathExtension(ext: "verblist")
            if FileManager.default.fileExists(atPath: vlPath!) == false {
                currentSelectedVerblist = nil
            }
            else {
                let newVL = Verblist()
                newVL.name = vlName!
                newVL.retrieveLocally()
                currentSelectedVerblist = newVL

            }
        }
        
//        if UDefs.defaultExists(forKey: K.keySelectedTab) {
            selectedTab = UDefs.string(forKey: K.keySelectedTab, withDefault: "drill")
//        }
        
        if UDefs.defaultExists(forKey: K.keyPronounDisplay) {
            showPronounWithAnswer = UDefs.bool(forKey: K.keyPronounDisplay)!
        }
        
        if UDefs.defaultExists(forKey: K.keySingleVerbSelected) {
            currentSelectedSingleVerbInfinitive = UDefs.string(forKey: K.keySingleVerbSelected)
        }
        
        if UDefs.defaultExists(forKey: K.keySearchStr) {
            currentSearchStr = UDefs.string(forKey: K.keySearchStr) ?? ""
        }
        
        if UDefs.defaultExists(forKey: K.keyQuizSelectionMode) {
            let val = UDefs.int32(forKey: K.keyQuizSelectionMode, withDefault: 0)
            verbSelectMode = Quiz_selection_mode.init(rawValue: val)!
            
        }
        
        currentSearchStr = ""
        if UDefs.defaultExists(forKey: K.keySearchStr) {
            if let val = UDefs.string(forKey: K.keySearchStr) {
                currentSearchStr = val
            }
            else {
                currentSearchStr = ""

            }
        }
        if UDefs.defaultExists(forKey: K.keyAutoSettingQuizDuration) {
            drillDuration = UDefs.int32(forKey: K.keyAutoSettingQuizDuration)!
        }
        else {
            drillDuration = 5
        }
        
        if UDefs.defaultExists(forKey: K.keyAutoSettingAnswerDuration) {
            answerDuration = UDefs.int32(forKey: K.keyAutoSettingAnswerDuration)!
        }
        else {
            answerDuration = 5
        }
        
        if UDefs.defaultExists(forKey: K.keyTenseLocale) {
            let rawV = UDefs.int(forKey: K.keyTenseLocale)!
            tenseLocale = tense_location(rawValue: rawV)!
        }
        else {
            tenseLocale = .default_locale
        }
        

        
    }
    
    func printYourself() {
        Log.print("verbSelectMode: \(verbSelectMode)")
        
        Log.print("drillDuration: \(drillDuration)")
        Log.print("answerDuration: \(answerDuration)")
        if currentSelectedSingleVerbInfinitive != nil {
            Log.print("currentSelectedSingleVerbInfinitive: \( currentSelectedSingleVerbInfinitive!)")
        }
        else {
            Log.print("currentSelectedSingleVerbInfinitive: nil")
        }
        if currentSelectedVerbListName != nil {
            Log.print("CurrentSelectedVerblistName: \(currentSelectedVerbListName!)")
        }
        else {
            Log.print("CurrentSelectedVerblistName is nil.")
        }
        if currentSelectedVerblist != nil {
            Log.print("currentSelectedVerbList.name: \(currentSelectedVerblist!.name), uuid: \(currentSelectedVerblist!.uuid!)")
            var c = 1
            for inf in currentSelectedVerblist!.infinitives {
                Log.print("\(c): \(inf)")
                c += 1
            }
        }
        else {
            Log.print("currentSelectedVerbList: nil")
        }
    }
}
