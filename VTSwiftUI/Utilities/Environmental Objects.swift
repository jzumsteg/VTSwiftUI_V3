//
//  Environmental Objects.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/25/22.
//

import Foundation
class EnvironmentalObjects: ObservableObject {
    
    // environmental objects not requiring persistance
    @Published var selectedInfinitive: String = ""
    @Published  var allVerbLists: Verblists = Verblists()
    @Published var redrawVerblists: Bool = false
    
    // environmental objects to be persisted. Persistance is done in Params.shared. Doing this keeps Params as the "signle source of truth" for these properties.
    @Published var tenseLocale: tense_location = tense_location() {
        didSet {
            Params.shared.tenseLocale = tenseLocale
        }
    }
    
    @Published var currentInfinitiveDisplayMode: Infinitive_list_display {
        didSet {
            Params.shared.infinitiveDisplay = currentInfinitiveDisplayMode
        }
    }
    
    @Published var selectedTab: String {
        didSet {
            Params.shared.selectedTab = selectedTab
        }
    }
    
    @Published var translationWhen: Translation_when {
        didSet {
            Params.shared.translationWhen = translationWhen
        }
    }

    @Published var translationWhat: Translation_what {
        didSet {
            Params.shared.translationWhat = translationWhat
        }
    }
    @Published var currentVerbInfinitive: String = "" {
        willSet {
            objectWillChange.send()
            Log.print("'currentVerbInfinitive' will change to \(newValue)")
        }
    }
    @Published var currentDisplayMode: Quiz_selection_mode {
        willSet {
            objectWillChange.send()
            Log.print("'currentDisplayMode' will change to \(newValue)")
            Params.shared.verbSelectMode = newValue
        }
    }
    @Published var currentVerblist: Verblist = Verblist() {
        willSet {
            objectWillChange.send()
            Log.print("Current verb list: \(newValue.name)")
            Params.shared.currentSelectedVerblist = newValue
            Params.shared.currentSelectedVerbListName = newValue.name
        }
    }
    
    @Published var currentDisplayVerb: Verb = Verb() {
        willSet {
            objectWillChange.send()
            Log.print("Current verb answer: \(newValue.answer)")
        }
    }
    
    @Published var drillSource = "Unknown source"
    
//    @Published var whatTranslation: Translation_what {
//        didSet {
//            UDefs.set(value: whatTranslation.rawValue, forKey: K.keyTranslationWhat)
//        }
//    }
//
//    @Published var whenTranslation: Translation_when {
//        didSet {
//            UDefs.set(value: whenTranslation.rawValue, forKey: K.keyTranslationWhen)
//        }
//    }
    
    init() {
        translationWhen = Params.shared.translationWhen
        translationWhat = Params.shared.translationWhat
        currentInfinitiveDisplayMode = Params.shared.infinitiveDisplay
        currentDisplayMode = Params.shared.verbSelectMode
        tenseLocale = Params.shared.tenseLocale
        selectedTab = Params.shared.selectedTab
        Log.print("selectedTab: \(selectedTab)")
        updateDrillSource()
    }
    
    func updateDrillSource() {
        switch Params.shared.verbSelectMode {
        case .use_one_verb:
            if  Params.shared.currentSelectedSingleVerbInfinitive != nil {
                drillSource = "Using \"\(Params.shared.currentSelectedSingleVerbInfinitive!).\""
            }
            else {
                drillSource = "Error: single selected verb is nil."
            }
        case .use_all_verbs:
            drillSource = "Using all verbs."
        case .use_verb_list:
            if Params.shared.currentSelectedVerblist != nil {
                drillSource = "Using verb list \"\(Params.shared.currentSelectedVerblist!.name).\""
            }
            else {
                drillSource = "Error: verblist.name is nil"
            }
        }

    }
    
    func updateVerblists() {
        allVerbLists = Verblists()
    }


    
    func printYourself() {
        Log.print("currentVerbInfinitive: \(currentVerbInfinitive)")
        Log.print("currentDisplayMode: \(currentDisplayMode)")
        Log.print("Current verb list: \(currentVerblist.name)")
    }
    
    
    
}
