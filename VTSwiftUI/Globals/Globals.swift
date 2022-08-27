//
//  Globals.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/18/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
import UIKit

struct K {
    static var keyColorScheme = "keyColorScheme"
    static var keySingleVerbSelected = "keySingleVerbSelected"  // the infinitive of a single verb selected for quizzes
    static var keyVerbListSelected = "keyVerbListselected"
    static var keyTranslationWhen = "keytranslationwhen"
    static var keyTranslationWhat = "keyTranslationWhat"
    static var keyInfinitiveDisplay = "keyInfinitiveDisplay"
    static var keyPronounDisplay = "keyPronounDisplay"
    static var keyAutoSettingQuizDuration = "autoSettingQuizDuration"
    static var keyAutoSettingAnswerDuration = "autoSettingAnswerDuration"
    static var numberVerbs = "keyQuizNumberVerbs"
    static var quizSeconds = "keyQuizSeconds"
    static var quizType = "keyQuizType"
    static var retestCorrect = "keyRetestCorrect"
    static var showTranslation = "keyShowTranslation"
    static var keyReachable = "keyReachable"
    static var keyQuizSelectionMode = "keyQuizSelectionMode"
    
    static var keyInfinitiveListToggle = "keyInfinitiveListToggle"
    static var keyTenseLocale = "keyTenseLocale"
    static var showIrregColors = "showIrregColors"

    static var keySearchStr = "keySearchStr"
    static var keyVerbListSelectedName = "keyVerbListSelectedName"
    
    static var keySelectedTab = "keySelectedTab"
}

//struct NotificationKeys {
//    static var notificationColorSchemeChanged = "notificationColorSchemeChanged"
//}

struct Globals {
    static var frameColor = UIColor(red: 0.0, green: 0.0, blue: 125/255.0, alpha: 0.6).cgColor
    static var version = "5.0"
    static var verbListExt = "verblist"
    static var keyNotification_VerbListChanged = "VerbListChanged"
}

let ON = true
let OFF = false

//translation mode
struct TranslationGlobals {
}

// infinitive_mode


// autoSettings
struct AutoSettingsGlobals {
    static var quizDuration = "autoSettingQuizDuration"
    static var answerDuration = "autoSettingAnswerDuration"
}

var SIMPLE_TENSES = 0
var COMPOUND_TENSES = 1
var TYPES = 2
var ENDINGS = 3
var PERSONS = 4

var tableRowHeight: CGFloat {
    get {
        var tblRowHeight = 36.0
        let  contentSize = UIApplication.shared.preferredContentSizeCategory
//        Log.print("preferred content size: \(contentSize)")
        switch contentSize {
        case UIContentSizeCategory.extraSmall:
            tblRowHeight = 32.0
        case UIContentSizeCategory.small:
            tblRowHeight = 36.0
        case UIContentSizeCategory.medium:
            tblRowHeight = 39.0
        case UIContentSizeCategory.large:
            tblRowHeight = 42.0
        case UIContentSizeCategory.extraLarge:
            tblRowHeight = 46.0
        case UIContentSizeCategory.extraExtraLarge:
            tblRowHeight = 52.0
        case UIContentSizeCategory.extraExtraExtraLarge:
            tblRowHeight = 56.0
        case UIContentSizeCategory.accessibilityMedium:
            tblRowHeight = 68.0
        case UIContentSizeCategory.accessibilityLarge:
            tblRowHeight = 84.0
        case UIContentSizeCategory.accessibilityExtraLarge:
            tblRowHeight = 124.0
        case UIContentSizeCategory.accessibilityExtraExtraLarge:
            tblRowHeight = 164.0
        case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            tblRowHeight = 184.0
        default:
            tblRowHeight = 36.0
        }
        
        return CGFloat(tblRowHeight)
    }
}
