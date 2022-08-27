//
//  ViewOptions.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 12/22/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//

import Foundation
class ViewOptions {
    var showIrregColors: Bool {

        didSet {
            UDefs.set(value: showIrregColors, forKey: K.showIrregColors)
        }
    }

    var translationWhat: Translation_what? {
        didSet {
            guard let val = translationWhat?.rawValue else {
                UDefs.removeObject(aKey: K.keyTranslationWhat)
                return
            }
            UDefs.set(value: val, forKey: K.keyTranslationWhat)
        }
    }
    var translationWhen: Translation_when? {
        didSet {
            guard let val = translationWhen?.rawValue else {
                UDefs.removeObject(aKey: K.keyTranslationWhen)
                return
            }
            UDefs.set(value: val, forKey: K.keyTranslationWhen)
        }
    }
    var infinitiveDisplay: Infinitive_display? {
        didSet {
            guard let val = infinitiveDisplay?.rawValue else {
                UDefs.removeObject(aKey: K.keyInfinitiveDisplay)
                return
            }
            UDefs.set(value: val, forKey: K.keyInfinitiveDisplay)
        }
    }
    var pronounDisplay: Pronoun_display? {
        didSet {
            guard let val = pronounDisplay?.rawValue else {
                UDefs.removeObject(aKey: K.keyPronounDisplay)
                return
            }
            UDefs.set(value: val, forKey: K.keyPronounDisplay)
        }
    }
    
    static let shared: ViewOptions = ViewOptions()
    
    private init() {
        let temp = UDefs.bool(forKey: K.showIrregColors)
        if temp == nil {
            showIrregColors = false
            UDefs.set(value: false, forKey: K.showIrregColors)
        }
        else {
            showIrregColors = UDefs.bool(forKey: K.showIrregColors)!
        }
        translationWhen = Translation_when()
        translationWhat = Translation_what()
        infinitiveDisplay = Infinitive_display()
        pronounDisplay = Pronoun_display()
    }

}
