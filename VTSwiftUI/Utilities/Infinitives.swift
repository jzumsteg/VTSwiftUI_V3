//
//  Infinitives.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 7/19/17.
//  Copyright © 2017 verbtrainers. All rights reserved.
//

import Foundation

class Infinitives {
    //MARK: - get infinitives
    class func getLanguageInfinitivesIntoArray() -> [String] {
        var arr = [String]()
        let db = DB.shared.verbDb
        let sql = "SELECT infinitive, english FROM verbtypes ORDER BY infinitive;"
        let rs = db.executeQuery(sql, withArgumentsIn: [])
        while (rs?.next())! {
            var inf = String()
            var eng = String()
            
            if let x = rs?.string(forColumn:"infinitive") {
                inf = x
            }
            if let x = rs?.string(forColumn: "english") {
                eng = x
            }
            arr.append("\(inf) (\(eng))")
            
        }
        return arr
    }
    
    class func getEnglishInfinitivesIntoArray() -> [String] {
        var arr = [String]()
        let db = DB.shared.verbDb
        let sql = "SELECT infinitive, english FROM verbtypes ORDER BY english;"
        let rs = db.executeQuery(sql, withArgumentsIn: [])
        while (rs?.next())! {
            var inf = String()
            var eng = String()
            if let x = rs?.string(forColumn:"infinitive") {
                inf = x
            }
            if let x = rs?.string(forColumn: "english") {
                eng = x
            }
            arr.append("\(eng) (\(inf))")
            
        }
        return arr
    }
    
    
    class func theInfinitive(textStr: String) -> String {
        let words = textStr.components(separatedBy: "(")
        var infStr: String
        infStr = words[0].trimmingCharacters(in: CharacterSet.whitespaces)
        
        return infStr
    }
    
    class func getLanguageInfinitivesOnly() -> [String] {
        var finalArray = [String]()
        let infinitives: [String] = Infinitives.getLanguageInfinitivesIntoArray()
        for inf in infinitives {
            let infedited = Infinitives.theInfinitive(textStr: inf, language: .language)
            finalArray.append(infedited)
        }
        
        return finalArray
    }
    
    class func theInfinitive(textStr: String, language: Infinitive_list_display) -> String {
        let words = textStr.components(separatedBy: "(")
        var infStr: String
        
        switch language {
        case .english:
            infStr = words[1].trimmingCharacters(in: CharacterSet.whitespaces)
            infStr = infStr.replacingOccurrences(of: ")", with: "", options: [], range: nil)
        case .language:
            infStr = words[0].trimmingCharacters(in: CharacterSet.whitespaces)
        }
        return infStr
    }
    
    class func getInfinitivesIntoListArray(str: String, language: Infinitive_list_display) -> [String] {
        var filteredInfinitives: [String] = []
        var currentInfinitives: [String] = []
        let tstr = str.lowercased()
        var inf: [String] = [String]()
        
        switch language {
        case .language:
            inf = Infinitives.getLanguageInfinitivesIntoArray()
        case .english:
            inf = getEnglishInfinitivesIntoArray()
        }
        
        if (tstr.count > 0) {
            for infinitive in inf {
                let srchStr = infinitive.prefix(tstr.count)
//                if srchStr == "o" {
//                    Log.print("infinitive: \(infinitive), searchStr: \(String(srchStr))")
//                }
                if srchStr == tstr {
                    filteredInfinitives.append(infinitive)
                }
            }
            if filteredInfinitives.count > 0 {
                currentInfinitives = filteredInfinitives
            }
            else {
                currentInfinitives.append("No infinitives match search.")
            }
        }
        else {
            // nothing in the searchbox, use the original
            currentInfinitives = inf
        }
        return currentInfinitives
        
    }  // func getInfinitivesIntoListDictionary(str: String)
    
    

}
