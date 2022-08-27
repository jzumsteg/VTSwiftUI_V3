//
//  FullConjugationViewController.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 12/31/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import UIKit
import WebKit

class FullConjugationViewModel: ObservableObject {
    @Published var infinitives: [String] = [String]()
    var environmentals = EnvironmentalObjects()
      
    func retrieveConjugation(infinitive: String) -> String {
        var retStr: String
//        var selSql = String()
//        let db = DB.shared.verbDb
//        let device = UIDevice.current.userInterfaceIdiom
        
        retStr = Utilities.getConjugationHTML(inf: infinitive)
        
        // if the locale is the the alternative - this can only be in Verbos - we have to substitute the Castillian tense titles for the Latin American tense titles
        if environmentals.tenseLocale == .alternative_locale_1 {
            retStr = retStr.replace(target: "pretérito anterior", withString: "antipretérito")
            retStr = retStr.replace(target: "futuro perfecto", withString: "antefuturo")
            retStr = retStr.replace(target: "condicional presente", withString: "pospretérito")
            retStr = retStr.replace(target: "imperfecto de subjuntivo", withString: "pretérito subjuntivo")
            retStr = retStr.replace(target: "imperfecto", withString: "copretérito")
            retStr = retStr.replace(target: "imperfecto de subjuntivo (alt)", withString: "pretérito subjunctive (alt)")
            retStr = retStr.replace(target: "perfecto de indicativo", withString: "antepresente")
            retStr = retStr.replace(target: "pluscuamperfecto de indic.", withString: "antecopretérito")
            retStr = retStr.replace(target: "pretérito anterior", withString: "antepretérito")
            retStr = retStr.replace(target: "futuro perfecto", withString: "antefuturo")
            retStr = retStr.replace(target: "condicional compuesto", withString: "antepospretérito")
            retStr = retStr.replace(target: "perfecto de subjuntivo", withString: "antepresente subjunctivo")
            retStr = retStr.replace(target: "pluscuam. de subj.", withString: "antepretérito subjuntivo")
            retStr = retStr.replace(target: "pluscamperfecto de subj.", withString: "antepretérito subj.")
            retStr = retStr.replace(target: "pluscamperfecto de subj.(alt)", withString: "antepretérito subj.(alt)")
        }
        
        return retStr
    }
    
    func getInfinitives(searchStr: String, language: Infinitive_list_display) {
        infinitives = Infinitives.getInfinitivesIntoListArray(str: searchStr, language: language)
    }
    
    
} // class
