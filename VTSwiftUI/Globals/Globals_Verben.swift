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
    static var latestSettingDatabaseVersion = "5.0.2"
    static var appTitle = "Verben"
    static var settingsDatabaseName = "german.sqlite3"
    static var verbDatabaseName = "germanverbs.sqlite3"
    static var language = "German"
    static var verbListExt_old = "ger_list"
    
    static var language_prefix = "ger"
    static var infinitiveLabel = "Infinitiv"
    static var tenseLabel = "Zeitform"
    static var pronounLabel = "Pronomen"
    
}

//let prefix = "verbos"

struct Parts {
    static var infinitiveStr = "Infinitiv"
    static var pastParticiple = "Partizip perfekt"
    static var presParticiple = "Partizip präsens"
    static var gerund = "Gerund"
}

//
//let kTitle = "Verbos"
struct Persons {
    static var person0 = "All Persons/numbers"
    static var allPersons = "All Persons/numbers"
    static var person1 = "ich"
    static var person2 = "du"
    static var person3 = "er"
    static var person4 = "Sie (sing.)"
    static var person5 = "sie (sing.)"
    static var person6 = "es"
    static var person7 = "wir"
    static var person8 = "ihr"
    static var person9 = "sie (pl.)"
    static var person10 = "Sie (pl.)"
    static var person11 = ""
    static var person12 = ""
    static var firstSingular = "ich"
    static var secondSingular = "du"
    static var thirdSingular = "er, sie, es"
    static var firstPlural = "wir"
    static var secondPlural = "ihr"
    static var thirdPlural = "sie; Sie"
    static var vos = ""
}

struct Endings {
    static var ending0 = "All Verb Endings"
    static var ending1 = ""
    static var ending2 = ""
    static var ending3 = ""
}

