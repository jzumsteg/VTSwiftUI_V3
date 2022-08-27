//
//  TenseNames.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 10/3/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//


// this class goes into Verbos targets
import Foundation

class TenseNumbers {
    class func tenseIntFromString(tenseStr: String, tense_locale: tense_location = .default_locale) -> Int {
        var retVal: Int = 0
        let tenseArrayDefault = ["", "presente","imperfecto","pretérito","futuro","condicional presente","presente de subjuntivo","imperfecto de subjuntivo","imperfecto de subjuntivo (alt)","perfecto de indicativo","pluscuamperfecto de indic.", "pretérito anterior","futuro perfecto","condicional compuesto","perfecto de subjuntivo", "pluscuam. de subj.","pluscuam. de subj. (alt)", "imperativo"]
        
        let tenseArrayAlt1 = ["","presente","copretérito","pretérito","futuro","pospretérito","presente de subjuntivo","pretérito subjuntivo","pretérito subjunctive (alt)","antepresente","antecopretérito", "antepretérito","antefuturo","condicional compuesto","antepresente subjunctivo", "antepretérito subjuntivo","antpretérito subj. (alt)", "imperativo"]

        
        switch tense_locale {
        case .default_locale:
            retVal = tenseArrayDefault.firstIndex(of: tenseStr) ?? 0
        case .alternative_locale_1:
            retVal = tenseArrayAlt1.firstIndex(of: tenseStr) ?? 0
        }
      
        return retVal
    }
    
    class func tenseStringFromInt(tenseInt:Int, tense_locale: tense_location = .default_locale) -> String {
        let tenseArrayDefault = ["", "presente","imperfecto","pretérito","futuro","condicional presente","presente de subjuntivo","imperfecto de subjuntivo","imperfecto de subjuntivo (alt)","perfecto de indicativo","pluscuamperfecto de indic.", "pretérito anterior","futuro perfecto","condicional compuesto","perfecto de subjuntivo", "pluscuam. de subj.","pluscuam. de subj. (alt)", "imperativo"]
        
        let tenseArrayAlt1 = ["","presente","copretérito","pretérito","futuro","pospretérito","presente de subjuntivo","pretérito subjuntivo","pretérito subjunctive (alt)","antepresente","antecopretérito", "antepretérito","antefuturo","condicional compuesto","antepresente subjunctivo", "antepretéito subjuntivo","anteoretérito subj. (alt)", "imperativo"]

        var retString:String!
        switch tense_locale {
        case .default_locale:
            retString = tenseArrayDefault[tenseInt]
        case .alternative_locale_1:
            retString = tenseArrayAlt1[tenseInt]
        }
        return retString
        
    }
}
