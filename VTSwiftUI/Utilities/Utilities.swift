//
//  Utilities.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/18/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    func retrieveConjugation(infinitive: String) -> String {
        var retStr: String
//        var selSql = String()
//        let db = DB.shared.verbDb
//        let device = UIDevice.current.userInterfaceIdiom
        
        retStr = Utilities.getConjugationHTML(inf: infinitive)
        
        // if the locale is the the alternative - this can only be in Verbos - we have to substitute the Castillian tense titles for the Latin American tense titles
        if TenseNames.sharedInstance.tenseLocation == .alternative_locale_1 {
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
            retStr = retStr.replace(target: "pluscuam. de subj.", withString: "antepretéito subjuntivo")
            retStr = retStr.replace(target: "pluscamperfecto de subj.", withString: "antepretérito subj.")
            retStr = retStr.replace(target: "pluscamperfecto de subj.(alt)", withString: "antepretérito subj.(alt)")
        }
        
        return retStr
    }
    
    class func getVerbParts(inf: String) -> String {
//        let device = UIDevice.current.userInterfaceIdiom
        let verbDb = DB.shared.verbDb
        var partPast = String()
        var partPres = String()
        var ger = String()
        
        let leftColPct = "49%"
        let midColPct = "1%"
        let rightColPct = "49%"
        
        let escInf = inf.replacingOccurrences(of: "'", with: "''")
        let sqlStr = "SELECT participlePast, participlePresent, gerund from VERBTYPES where infinitive = '\(escInf)';"
        guard let rs = verbDb.executeQuery(sqlStr, withArgumentsIn: []) else {
            return "Error retrieving parts for \(inf) from verbsettings"
        }
        
        while rs.next() {
            partPast = rs.string(forColumn: "participlePast") ?? ""
            partPres = rs.string(forColumn: "participlePresent") ?? ""
            ger = rs.string(forColumn: "gerund") ?? ""
        }

//        var tableWidth: Int
//        switch device {
//        case .pad:
//            tableWidth = 800
//        case .phone:
//            tableWidth = Int(UIScreen.main.bounds.width  * 1.2)
//        default:
//            tableWidth = 360
//        }
//        tableWidth = 600
            
        let colorScheme = ColorScheme()
        let cssStr = VtColor.cssHTML(scheme: colorScheme)
        var conjHtmlStr = "\(cssStr)<div align=center><table style=\"width:95%\">"
        
        conjHtmlStr += "<tr><td width:\(leftColPct) align=right><std>\(Parts.infinitiveStr):</td><td width: \(midColPct)>&nbsp;</td><td width:\(rightColPct)><stdbld>\(inf)</stdbld></td></tr>"
        if partPres.count > 0 {
            conjHtmlStr += "<tr><td style=\"width:\(leftColPct)\" align=right><std>\(Parts.presParticiple):</std></td><td style=\"width:\(midColPct)\">&nbsp;</td><td style=\"width:\(rightColPct)\"><stdbld>\(partPres)</stdbld></td></tr>"
        }
        if partPast.count > 0 {
            conjHtmlStr += "<tr><td style=\"width:\(leftColPct)\" align=right><std>\(Parts.pastParticiple):</td></td><td style=\"width:\(midColPct)\">&nbsp;</td><td style=\"width:\(rightColPct)\"><stdbld>\(partPast)</stdbld></td></tr>"
        }
        if ger.count > 0 {
            conjHtmlStr += "<tr><td style=\"width:\(leftColPct)\" align=right><std>\(Parts.gerund):</td></td><td style=\"width:\(midColPct)\">&nbsp;</td><td style=\"width:\(rightColPct)\"><stdbld>\(ger)</stdbld></td></tr>"
        }
        
        conjHtmlStr += "</table></div></body></html>"
        return conjHtmlStr
    }
    class func getConjugationHTML (inf: String) -> String {
        //FIX-ME: Verbos has to have seven cells - to accomodate vos - while the others can have only six cells. Fix this up
        let device = UIDevice.current.userInterfaceIdiom
        var tenses = [String]()
        var cells = [String]()

        let db = DB.shared.stateDb
        let verbDb = DB.shared.verbDb
        // get an array of tenses
        guard let rs = db.executeQuery("SELECT setting_name FROM verbsettings WHERE tenseNumber > 0 ORDER BY tenseNumber", withArgumentsIn: []) else {
            return "Error retrieving conjugation from verbsettings"
        }
        
        while rs.next() {
            let tenseStr = rs.string(forColumn: "setting_name") ?? "null tense"
            tenses.append(tenseStr)
        }
        
//        var leftColWidth = 0
//        var rightColWidth = 0
        var numberColPct = ""
        var formColPct = ""
//        let retStr = ""
//        var tableWidth: Int
        Log.print("UIScreenmain.bounds.width: \(Int(UIScreen.main.bounds.width)), height: \(Int(UIScreen.main.bounds.height))")
        switch device {
        case .pad:
//            tableWidth = Int(UIScreen.main.bounds.width * 0.45)
            numberColPct = "24"
            formColPct = "24"
        case .phone:
//            tableWidth = Int(UIScreen.main.bounds.width * 0.95)
            numberColPct = "49"
            formColPct = "49"
//            tableWidth = 95
        default:
//            tableWidth = Int(UIScreen.main.bounds.width * 0.95)
            print("default")
        }
        
        let colorScheme = ColorScheme()
        let cssStr = VtColor.cssHTML(scheme: colorScheme)
        var conjHtmlStr = "\(cssStr)\n<html><body><div align=center><table>"
        // first construct the tense header line
        for tense in 1...tenses.count {
            cells.removeAll()
            cells.append("<td align=right style=\"width:\(numberColPct)%\"><std>\(Persons.firstSingular)</std></td><td style=\"width:1%\">&nbsp;</td><td  style=\"width:\(formColPct)%\"><stdbld>-</stdbld></td>")
            cells.append("<td align=right style=\"width:\(numberColPct)%\"><std>\(Persons.secondSingular)</std></td><td style=\"width:1%\"&nbsp;</td></td><td style=\"width:\(formColPct)%\"><stdbld>-</stdbld></td>")
            cells.append("<td align=right style=\"width:\(numberColPct)%\"><std>\(Persons.thirdSingular)</std></td><td style=\"width:1%\">&nbsp;</td><td style=\"width:\(formColPct)%\"><stdbld>-</stdbld></td>")
            cells.append("<td align=right style=\"width:\(numberColPct)%\"><std>\(Persons.firstPlural)</std></td><td style=\"width:1%\">&nbsp;</td><td  style=\"width:\(formColPct)%\"><stdbld>-</stdbld></td>")
            cells.append("<td align=right style=\"width:\(numberColPct)%\"><std>\(Persons.secondPlural)</std></td><td style=\"width:1%\">&nbsp;</td><td style=\"width:\(formColPct)%\"><stdbld>-</stdbld></td>")
            cells.append("<td align=right style=\"width:\(numberColPct)%\"><std>\(Persons.thirdPlural)</std></td><td style=\"width:1%\">&nbsp;</td><td style=\"width:\(formColPct)\(formColPct)%\"><stdbld>-</stdbld></td>")
            
            if LanguageGlobals.appTitle == "Verbos" {
                cells.append("<td align=right style=\"width:\(formColPct)%\"><std>\(Persons.vos)</std></td><td style=\"width:1%\">&nbsp;</td></td><td  style=\"width:\(formColPct)%\"><stdbld>-</stdbld></td>")

            }
//            Log.print("Doing tense \(tense)")
            // first construct the tense header line
            conjHtmlStr += "<tr height=12><td colspan=6 align=center bgcolor=lightsteelblue><hdr>\(tenses[tense-1])</hdr></td></tr>"
            
            // now get the generic tenses
            
            let escInf = inf.replacingOccurrences(of: "'", with: "''")
            let sql = "SELECT DISTINCT verb, tense, genericnumber FROM verbs WHERE infinitive = '\(escInf)' AND tense = \(tense) ORDER BY tense, genericnumber;"
            guard let rsvf = verbDb.executeQuery(sql, withArgumentsIn: []) else {
                return ""
            }
            var personStr = ""
            while rsvf.next() {
                let genNum = rsvf.int(forColumn: "genericnumber")
                let vf = rsvf.string(forColumn: "verb") ?? "&nbsp;"
                // add this row to the conjhtmlStr
                switch genNum {
                case 1:
                    personStr = Persons.firstSingular
                case 2:
                    personStr = Persons.secondSingular
                case 3:
                    personStr = Persons.thirdSingular
                case 4:
                    personStr = Persons.firstPlural
                case 5:
                    personStr = Persons.secondPlural
                case 6:
                    personStr = Persons.thirdPlural
                case 7:
                    personStr = Persons.vos
                default:
                    personStr = "No Person/number"
                }
                cells[Int(genNum - 1)] = "<td align=right width=23%><std>\(personStr)</std></td><td width=1%>&nbsp;</td><td width=25%><stdbld>\(vf)</stdbld></td>"
//                cells.append("<td align=right width=25%><std>\(personStr)</std></td><td width=25%><stdbld>\(vf)</stdbld></td>")
            }
            
            if cells.count == 0 {
                return "No records found for the infinitive '\(inf)'"
            }
            
            // at this point, all the persons for this tense are in a cells array, ordered 1 tp 6 or 7 (for Verbos)
            switch device {
            case .phone:
                for person in 1...cells.count {
                    conjHtmlStr += "<tr>\(cells[person - 1])</tr>"
                }
            case .pad:
                for person in 0...(cells.count / 2) - 1  {
                    conjHtmlStr += "<tr>\(cells[person])\(cells[person + 3])</tr>"
                }
                if cells.count % 2 != 0 {
                    // this means that there is an odd number of cells and we have to do one last one}
                    conjHtmlStr += "<tr>\(cells.last!)</td><td>&nbsp;</td></tr>"
                }

            default:
                break
                
            }
            
        }
            

        conjHtmlStr += "</table></div></body></html>"
        return conjHtmlStr
    }
    
    
    class func escapeApostrophes(inputStr: String) -> String {
        return inputStr.replace(target: "'", withString:"''")  
    }
    class func integerWithCommas(num: Int32) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:num)) ?? "NA"
    }
    
    class func integerWithCommas(num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:num))  ?? "NA"
    }
    
    class func deleteAllVerblists() {
        var array: [String] = Array()
        let fileManager = FileManager.default
        let documentsDirectory = FileUtilities.verbListPath()
        do {
            array =  try fileManager.contentsOfDirectory(atPath: documentsDirectory) as Array<String>
        } catch let error1 as NSError {
            Log.errorMsg(error1.description)
        }
        for name in array {
            do {
                let fullPath = FileUtilities.verbListDirectoryPath().stringByAppendingPathComponent(path: name)
                try fileManager.removeItem(atPath: fullPath)
            } catch let error1 as NSError {
                Log.errorMsg(error1.description)
            }
        }
 
    }
    
    class func getVerblistNames() -> [String] {
        Log.methodEnter()
        
        let dic = Utilities.getVerbListDic()
        return [String](dic.keys)
//        var array: [String] = Array()
//        var newArray: [String] = Array()
//
//
//        let fileManager = FileManager.default
//        let documentsDirectory = FileUtilities.documentsDirectory().stringByAppendingPathComponent(path: "verblists")
//
//        do {
//            array =  try fileManager.contentsOfDirectory(atPath: documentsDirectory) as Array<String>
//        } catch let error1 as NSError {
//            Log.errorMsg(error1.description)
//        }
//        for verblist in array {
//            let vl = Verblist()
//            vl.name = verblist.stringByDeletingPathExtension
//            Log.print("vl.name: \(vl.name)")
//            newArray.append(vl.name)
//        }
//
//        return newArray;
    }
    
    class func getVerblistUUIDs() -> [String] {
        Log.methodEnter()
        var vlPaths: [String] = Array()
        var newArray: [String] = Array()
        
        
        let fileManager = FileManager.default
        let documentsDirectory = FileUtilities.documentsDirectory().stringByAppendingPathComponent(path: "verblists")
        
        do {
            vlPaths =  try fileManager.contentsOfDirectory(atPath: documentsDirectory) as Array<String>
        } catch let error1 as NSError {
            Log.errorMsg(error1.description)
        }
        for vlPath in vlPaths {
            if vlPath.hasSuffix(".verblist") == true {  // process only verblists. Use suffix when it is out of beta
                newArray.append(vlPath.stringByDeletingPathExtension)
            }
        }
        
        return newArray;
    }
    class func getVerbListDic() -> [String:Verblist] {
        
        var verblistDic: [String:Verblist]
        verblistDic = Dictionary()
        let verbListPaths = FileUtilities.getVerbListPaths()
        for vlPath in verbListPaths {
            if vlPath.hasSuffix(".verblist") == true {  // process only verblists. Use suffix when it is out of beta
                //            let vlName = vlPath.stringByDeletingPathExtension
                let vlName = vlPath.stringByDeletingPathExtension
                let newVerbList = Verblist(verblistname: vlName)
                newVerbList.retrieveLocally()
                verblistDic[vlName] = newVerbList
            }
        }
        return verblistDic
    }

    
    class func getVerbLists() -> [Verblist] {
        var verblists = [Verblist]()
        verblists.removeAll()
        let verbListPaths = FileUtilities.getVerbListPaths()
        for vlPath in verbListPaths {
            if vlPath.hasSuffix(".verblist") == true {  // process only verblists. Use suffix when it is out of beta
    //            let vlName = vlPath.stringByDeletingPathExtension
                let vlName = vlPath.stringByDeletingPathExtension
                let newVerbList = Verblist(verblistname: vlName)
                newVerbList.retrieveLocally()
                verblists.append(newVerbList)
            }
            else {
                // delete any non-verblists
                do {
                    try FileManager.default.removeItem(atPath: vlPath)
                } catch {
                    Log.print("Could not delete \(vlPath)")
                }
            }
        }
        let vlSorted = verblists.sorted(by: { $0.name < $1.name })
        return vlSorted
    }
    
    class func getVerbListsAndVerbListNames() -> (verblists: [Verblist], listnames: [String]) {
        let vlists = Utilities.getVerbLists()
        var vlNames = [String]()
        for vl in vlists {
            vlNames.append(vl.name)
        }
        return (vlists, vlNames)
        
    }
    
    class func getVerblistsInfo() -> (verblists: [Verblist], listnames: [String], listpaths: [String]) {
        let vlists = Utilities.getVerbLists()
        var vlNames = [String]()
        var vlPaths = [String]()
        for vl in vlists {
            vlNames.append(vl.name)
            vlPaths.append(FileUtilities.verbListPath(file: vl.uuid))
        }
        return (vlists, vlNames, vlPaths)
        
    }

    class func device() -> NSString {
        let device = UIDevice.current.model
        Log.print("Device: \(device)")
        return device as NSString
    }
    
    class func printVerbSelectionMode () {
        var prtVal = ""
        let mode = Params.shared.verbSelectMode
//        mode.retrieve()
        switch mode {
        case .use_all_verbs:
            prtVal = ".use_all_verbs"
        case .use_one_verb:
            prtVal = ".use_one_verb: \(String(describing: UDefs.string(forKey: K.keySingleVerbSelected)))"
        case .use_verb_list:
            let vrbListStr = UDefs.string(forKey: K.keyVerbListSelected)
            prtVal = ".use_verb_list; verblist: \(String(describing: vrbListStr))"
        }

    Log.print("VerbSelectionMode = \(prtVal)")

        
    }
    
    class func getPNG(png: String) -> UIImage {
        guard let pngPath = FileUtilities.resourceDirectory().stringByAppendingPathComponent(path: png).stringByAppendingPathExtension(ext: "png") else {return UIImage()}
        guard let img = UIImage(contentsOfFile: pngPath) else {return UIImage()}
        return img
        
    }
    
    class func clearUbiquityContainer() {
//        var error: NSError?
//        let K: NSDictionary = NSUbiquitousKtore.default.dictionaryRepresentation as NSDictionary
//        let keys = K.allKeys
//        for k in keys {
//            NSUbiquitousKtore.default.removeObject(forKey: String(k as! NSString))
//        }
//
//        let fm = FileManager.default
//        // delete the Document directory
//        let ucPath = fm.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").path
//        if let _ = ucPath {
//            do {
//                try fm.removeItem(atPath: ucPath!)
//            } catch let error1 as NSError {
//                Log.errorMsg(error1.description)
//            }
//        }
//        else {
//            Log.print("could not remove Documents directory")
//        }
//
//        if let ucPath = fm.url(forUbiquityContainerIdentifier: nil)?.path {
//            let enumerator:FileManager.DirectoryEnumerator = fm.enumerator(atPath: ucPath)!
//            while let element = enumerator.nextObject() as? String {
//                let fPath = ucPath.stringByAppendingPathComponent(path: element)
//                do {
//                    try fm.removeItem(atPath: fPath)
//                } catch let error1 as NSError {
//                    Log.errorMsg(error1.description)
//                }
//            }
//        }
//
//        Utilities.printUbiquityContainerContents()
//        Utilities.printUbiquityContainerK()
    }

    
    class func printUbiquityContainerK() {
//        let K: NSDictionary = NSUbiquitousKtore.default.dictionaryRepresentation as NSDictionary
//        let keys = K.allKeys
//        Log.print("ubiquityContainer K:")
//        for k in keys {
//            Log.print("     key: \(k)")
//        }
//        Log.print("==============================")
        
    }
    
    class func printUbiquityContainerContents() {
//        var error: NSError?
        Log.print("==============================")
        let fm = FileManager.default
        if let ucPath = fm.url(forUbiquityContainerIdentifier: nil)?.path {
            Log.print("ucPath: \(ucPath)")
            let enumerator:FileManager.DirectoryEnumerator = fm.enumerator(atPath: ucPath)!
            while let element = enumerator.nextObject() as? String {
//                var fPath = ucPath.stringByAppendingPathComponent(element)
                let fullPath = ucPath.stringByAppendingPathComponent(path: element)
                let attribs: NSDictionary?
                do {
                    attribs = try fm.attributesOfItem(atPath: fullPath) as NSDictionary?
                } catch let error1 as NSError {
                    Log.errorMsg(error1.description)
                    attribs = nil
                }
                
                if let fileattribs = attribs {
                    let fType = fileattribs["NSFileType"] as! String
                    if fType != "NSFileTypeDirectory" {
                    
                        let fSize = fileattribs["NSFileSize"]
                        let fDate = fileattribs["NSFileModificationDate"]
                        Log.print("\(element): size: \(String(describing: fSize)), mod date: \(String(describing: fDate)))")
                }
                }
            }
        }
    Log.print("==============================")
    }

    
    class func getUbiquityContainerContents() -> [String] {
        //        var error: NSError?
        var files: [String]
        files = Array()
        
        let fm = FileManager.default
        if let ucPath = fm.url(forUbiquityContainerIdentifier: nil)?.path {
            Log.print("ucPath: \(ucPath)")
            let enumerator:FileManager.DirectoryEnumerator = fm.enumerator(atPath: ucPath)!
            while let element = enumerator.nextObject() as? String {
                //                var fPath = ucPath.stringByAppendingPathComponent(element)
                let fullPath = ucPath.stringByAppendingPathComponent(path: element)
                let attribs: NSDictionary?
                do {
                    attribs = try fm.attributesOfItem(atPath: fullPath) as NSDictionary?
                } catch let error1 as NSError {
                    Log.errorMsg(error1.description)
                    attribs = nil
                }
                
                if let fileattribs = attribs {
                    let fType = fileattribs["NSFileType"] as! String
                    if fType != "NSFileTypeDirectory" {
                        
                        let fSize = fileattribs["NSFileSize"]
                        let fDate = fileattribs["NSFileModificationDate"]
                        files.append("\(element) : \(String(describing: fSize)) : \(String(describing: fDate))")
                    }
                }
            }
        }
        return files
    }

    class func borderView(v: UIView) {
        v.layer.borderColor =  Globals.frameColor
        v.layer.borderWidth = 1.0;
        v.layer.cornerRadius = 5;
        v.layer.masksToBounds = true;
        
    }

    
    class func printUserDefaults() {
        let keys = [K.keyTranslationWhat,K.keyTranslationWhen,K.keyQuizSelectionMode,K.keyInfinitiveDisplay,K.keyPronounDisplay, K.keyQuizSelectionMode, K.keySingleVerbSelected, K.keyVerbListSelected]
        Log.print("UserDefaults --------------")
        let userDict = UserDefaults.standard.dictionaryRepresentation()
        
        for key in keys {
            if let udStr = userDict[key] {
                Log.print("\(key) userDefaults: \(udStr)")
            }
            else {
                Log.print("\(key) does not exist in UserDefaults")
            }
        }
        Log.print("---------------------------")
    }
    

    class func makeUIColor(red: Float, green: Float, blue: Float) -> UIColor {
        return UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
    }
    
    class func makeUIColor(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(alpha))
    }
    


}
