//
//  Verb.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/14/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
import FMDB

class Verb: ObservableObject {
    var id: Int32
    var infinitive: String
    var tense: String
    var number: String
    var answer: String
    var english: String
    var translation: String
    var gender: Int
    var tenseNumber: Int
    var personNumber: Int   // in database: genericNumber
    var fullPersonNumber: Int  // in database: genericNumber2
    var preposition: String!  // not used yet
    var regular: Bool
    var irregular: Bool
    var stemchanging: Bool
    var orthochanging: Bool
    var irregParticiple: Bool
    
    var db = DB.shared.verbDb
    
    
    init() {
        id = 0
        infinitive = "N/A"
        tense = "N/A"
        number = "N/A"
        answer = "N/A"
        english = "N/A"
        translation = "N/A"
        preposition = ""
        gender = 0
        tenseNumber = 0
        personNumber = 1
        fullPersonNumber = 1
        regular = true
        irregular = false
        orthochanging = false
        stemchanging = false
        irregParticiple = false
    }
    
    convenience init(inf: String, tens: String, num: String, ans: String, eng: String, trans: String, gen: Int, tenseNum: Int) {
        self.init()
        id = 0
        infinitive = inf
        tense = tens
        number = num
        answer = ans
        english = eng
        translation = trans
        gender = gen
        tenseNumber = tenseNum
    }
    
    convenience init(inf: String, fullPersonNum: Int, tenseNum: Int) {
        self.init()
        infinitive = inf
        fullPersonNumber = fullPersonNum
        tenseNumber = tenseNum
    }
    
    func retrieve() {
        guard let rs: FMResultSet = db.executeQuery("SELECT * FROM verbs WHERE infinitive = ? AND tense = ?  AND genericNumber2 = ?;", withArgumentsIn: [infinitive, tenseNumber, fullPersonNumber]) else {
            Log.print("db.executeQuery failed \(db.lastError())")
            return
        }
        if rs.next() {
            
            id = Int32(rs.int(forColumn: "id"))
            if let unwrapped = rs.string(forColumn: "number") {
                number = unwrapped
            }
            answer = rs.string(forColumn: "verb")!
            english = rs.string(forColumn: "english")!
            translation = rs.string(forColumn: "translation")!
            regular = rs.bool(forColumn: "regular")
            irregular = rs.bool(forColumn: "irregular")
            orthochanging = rs.bool(forColumn: "orthochanging")
            stemchanging = rs.bool(forColumn: "stemchanging")
            irregParticiple = rs.bool(forColumn: "irregparticiple")
            if let unwrapped = rs.string(forColumn: "english") {
                english = unwrapped
                
            }
        }
    
    }
    
    
    func printYourself() {
        Log.print("infinitive: \(infinitive)")
        Log.print("tense: \(tense)")
        Log.print("number: \(number)")
        Log.print("answer: \(answer)")
        Log.print("english: \(english)")
        Log.print("translation: \(translation)")
        Log.print("gender: \(gender)")
        Log.print("tenseNumber: \(tenseNumber)")
        
    }
}
