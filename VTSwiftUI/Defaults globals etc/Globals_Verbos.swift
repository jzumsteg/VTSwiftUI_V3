//
//  Globals_Verbos.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/14/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
// vars in the section below will be available to all classes and structures
struct LanguageGlobals {
    static var latestSettingDatabaseVersion = "5.0.0"
    static var appTitle = "Verbos"
    static var settingsDatabaseName = "spanish.sqlite3"
//    static var verbDatabaseName = "spanishverbs.sqlite3"
    static var verbDatabaseName = "spanishverbs.sqlite3"
    static var language = "Spanish"
    static var verbListExt_old = "sp_list"
    
    static var language_prefix = "sp"
    static var infinitiveLabel = "Infinitivo"
    static var tenseLabel = "Tenso"
    static var pronounLabel = "Prenombre"
    
}

//let prefix = "verbos"

struct Parts {
    static var infinitiveStr = "Infinitivo"
    static var pastParticiple = "Participle Passé"
    static var presParticiple = "Participle Présent"
    static var gerund = "Gerund"
}

//
//let kTitle = "Verbos"
struct Persons {
    static var person0 = "All Persons/numbers"
    static var allPersons = "All Persons/numbers"
    static var person1 = "yo"
    static var person2 = "tú"
    static var person3 = "él"
    static var person4 = "ella"
    static var person5 = "Ud."
    static var person6 = "nosotros"
    static var person7 = "vosotros"
    static var person8 = "ellos"
    static var person9 = "ellas"
    static var person10 = "Uds."
    static var person11 = "vos"
    static var person12 = ""
    static var firstSingular = "yo"
    static var secondSingular = "tú"
    static var thirdSingular = "él, ella, Ud."
    static var firstPlural = "nosotros"
    static var secondPlural = "vosotros"
    static var thirdPlural = "ellos, ellas, Uds."
    static var vos = "vos"
}

struct Endings {
    static var ending0 = "All Verb Endings"
    static var ending1 = "-ar"
    static var ending2 = "-er"
    static var ending3 = "-ir"
}
//let kNumberOfTenses = 17
//let kNumberOfSimpleTenses = 9
//let kNumberOfCompoundTenses = 8
//let kNumberOfEndings = 3
//let kNumberOfPersons = 11
//let kNumberOfTypes = 6
//    


//var simpleTenseStrings:[String] = ["All Simple Tenses","presente","imperfecto","pretérito","futuro","condicional presente","presente de subjuntivo",
//                                 "imperfecto de subjuntivo","imperfecto de subjuntivo (alt)","imperativo"]
//var compoundTenseStrings: [String] = ["All Compound Tenses",
//                                      "perfecto de indicativo","pluscuamperfecto de indic.","pretérito anterior",
//                                      "futuro perfecto","condicional compuesto","perfecto de subjuntivo",
//                                      "pluscuam. de subj.","pluscuam. de subj. (alt)"]
//var endingStrings: [String] = ["All Verb Endings","-ar","-er","-ir"]
//var personStrings: [String] = ["All Persons/numbers","yo","tú","él","ella","Ud.","nosotros",
//                               "vosotros", "ellos","ellas","Uds.","vos"]
//var typeStrings: [String] = ["All Verb Types",
//                             "Regular","Irregular","Stem-changing","Ortho-changing",
//                             "Reflexive"]
//var allTenseStrings = simpleTenseStrings + compoundTenseStrings + endingStrings + personStrings + typeStrings
//
//
////TO-DO: make these Spanish. French is here now so it won't blow up
//var tenseStringArray: [String] = ["présent de l'ind.","imparfait de l'ind.","passé simple","futur simple","conditionnel présente","présent du subjonctif", "imparfait du subjonctif","plus-que-parfait de l'ind.", "passé composé",
//                                  "passé antérieur","futur antérieur","conditionnel passé","passé du subjonctif","plus-que-parfait du subj.","impératif présente"]
//
//var personStringArray: [String] = ["j'; je","elle","il","elles","nous","vous", "elles","ils"]
//let kTense1 = "presente"
//let kTense2 = "imperfecto"
//let kTense3 = "pretérito"
//let kTense4 = "futuro"
//let kTense5 = "condicional presente"
//let kTense6 = "presente de subjuntivo"
//let kTense7 = "imperfecto de subjuntivo"
//let kTense8 = "imperfecto de subjuntivo (alt)"
//let kTense9 = "perfecto de indicativo"
//let kTense10 = "pluscuamperfecto de indic."
//let kTense11 = "pretérito anterior"
//let kTense12 = "futuro perfecto"
//let kTense13 = "condicional compuesto"
//let kTense14 = "perfecto de subjuntivo"
//let kTense15 = "pluscuam. de subj."
//let kTense16 = "pluscuam. de subj. (alt)"
//let kTense17 = "imperativo"
//let kParticiplePresentLabel = "participio"
//let kParticiplePastLabel = ""
//let kGerundLabel = "gerundio"
//let kAllSimpleTenses = "All Simple Tenses"
//let kAllCompoundTenses = "All Compound Tenses"
//let kTense20 = "participio"
//let kTense21 = "gerundio"
//let kType1 = "All Verb Types"
//let kType2 = "Regular"
//let kType3 = "Irregular"
//let kType4 = "Stem-changing"
//let kType5 = "Ortho-changing"
//let kType6 = "Reflexive"
