//
//  VerbGenerator.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/16/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
import UIKit
import FMDB
import SwiftUI

class VerbGenerator: ObservableObject {
// MARK: Published properties
    @Published var displayVerb = Verb()
    @Published var currentVerbList: Verblist = Verblist()
    static let shared: VerbGenerator = VerbGenerator()
    //    var displayVerb = Verb()
    
// MARK: Class Properties
    var selection: Selection = Selection.shared
    var currentSingleVerb: String = ""
    var verbArrayIsUpdated: Bool = false
    
    var verbArray: [String] = Array()
    var db: FMDatabase!
    var tenseInfo = TenseNames.sharedInstance
    
    var recordCount: Int32 = 0
    
    var environmentals = EnvironmentalObjects()

    private init( ) {
        Log.methodEnter()
        
        verbArray = Array()
        
        db = DB.shared.verbDb
        currentSingleVerb = String()
        verbArrayIsUpdated = false
            
        if let _ = Params.shared.currentSelectedVerblist {
            recordCount = calculateRecordCount()
            verbArrayIsUpdated = true
        }
        Params.shared.printYourself()
        let verb_selection_mode = Params.shared.verbSelectMode
        if verb_selection_mode == .use_verb_list {
            if let val = Params.shared.currentSelectedVerblist?.name {
                currentVerbList.name = val
                currentVerbList.retrieveLocally()
                Params.shared.currentSelectedVerblist = currentVerbList
            }
            else {
                Params.shared.verbSelectMode = .use_all_verbs
            }
        }
        
        getVerb()
 

   }  // init()
    
    
    /// Retrieves a verb from the database.
    /// Uses Selection to get the WHERE clause
    /// - Parameters
    /// - Returns No explicit return, but the class property displayVerb is updated with a new verb
    func getVerb() {
        Log.methodEnter()
        
        let val = Params.shared.verbSelectMode
        Log.print("K.keyQuizSelectionMode value: \(val)")
//        Params.shared.verbSelectMode = .use_all_verbs
        let verb_selection_mode = Params.shared.verbSelectMode

        var verbClause: String = ""
        var whereClause: String = ""
        
        whereClause = selection.getWhereClause()
        Log.print("whereClause:'\(whereClause)'")
        Log.print("recordCount: \(recordCount), UInt32(recordCount): \(UInt32(recordCount))")
        Utilities.printVerbSelectionMode()
        
        switch verb_selection_mode {
        case .use_all_verbs:
            let r = arc4random_uniform(UInt32(recordCount)) + 1
            Log.print("r: \(r)")
            whereClause = selection.getWhereClause()
            verbClause = "SELECT * FROM verbs \(whereClause) ORDER BY RANDOM(), 1;"
            
        case .use_one_verb:
            verbClause = "SELECT * FROM verbs \(whereClause) ORDER BY RANDOM(), 1;"
            
                
        case .use_verb_list:
            guard Params.shared.currentSelectedVerblist != nil else {
                Log.errorMsg("currentVerbList seems to be nil.")
                Params.shared.verbSelectMode = .use_all_verbs
                return
            }
            verbClause = "SELECT * FROM verbs \(whereClause) ORDER BY RANDOM(), 1;"
                        
        }
        
        Log.print("verbClause: |\(verbClause)|")
        let retVerb: Verb = Verb()
        guard let rs = db.executeQuery(verbClause, withArgumentsIn: []) else {
            Log.print("db.executeQuery failed \(db.lastError())")
            return
        }

        let locale = Params.shared.tenseLocale
      if (rs.next()) {
            retVerb.id = Int32(rs.long(forColumn: "id"))
            retVerb.infinitive = rs.string(forColumn: "infinitive") ?? String()
            //TO-DO: figure out how to get an alternate - south american - set of tense strings here
            retVerb.tenseNumber = rs.long(forColumn: "tense")
//            retVerb.tense = TenseNumbers.tenseStringFromInt(tenseInt: retVerb.tenseNumber, tense_locale: tense_location(rawValue: locale)!)
            retVerb.tense = tenseInfo.getTenseStr(tenseNumber: Int32(retVerb.tenseNumber), tenseLocale: locale) ?? "Default tense - error!"
            retVerb.number = rs.string(forColumn: "number") ?? String()
            retVerb.answer = rs.string(forColumn: "verb") ?? String()
            retVerb.english = rs.string(forColumn: "english") ?? String()
            retVerb.gender = Int(rs.int(forColumn: "gender"))
            retVerb.translation = rs.string(forColumn: "translation") ?? String()
            retVerb.regular = rs.bool(forColumn: "regular")
            retVerb.irregular = rs.bool(forColumn: "irregular")
            retVerb.stemchanging = rs.bool(forColumn: "stemchanging")
            retVerb.orthochanging = rs.bool(forColumn: "orthochanging")
        }
        retVerb.printYourself()
        displayVerb = retVerb
        environmentals.currentVerbInfinitive = displayVerb.infinitive
//        return retVerb
        
    }
    
    func selectionIsValid() -> Bool {
        Log.methodEnter()
        
        return recordCount > 0 ? true : false
    }
    
    func isVerbListValid(vrbList: Verblist) -> Bool {
        var retVal = false
        var cnt: Int32 = 0
        let whereClause = selection.getWhereClause()
        let sqlStr = "SELECT count(*) as count FROM verbs " + whereClause + " AND infinitive = ?;"
        for inf in vrbList.infinitives {
            guard let rs = db.executeQuery(sqlStr, withArgumentsIn: [inf]) else {
                Log.print("db.executeQuery failed \(db.lastError())")
                return false
            }
            if rs.next() {
                let vrbCount = rs.int(forColumn: "count")
                cnt += vrbCount
            }
        }
        if cnt > 0 {
            retVal = true
        }
        return retVal
    }
    
    func isSingleVerbValid(vrb: String) -> Bool {
        var retVal: Bool = false
        var cnt: Int32
        
        var selStr = selection.getWhereClause()
        if selStr.count == 0 {
            selStr = "SELECT count(*) AS count FROM verbs WHERE infinitive = '\(vrb)';"
        }
        else {
            selStr = "SELECT count(*) AS count FROM verbs " + selStr + " AND infinitive = '\(vrb)';"
        }
        Log.print("selStr: \(selStr)")
        guard let rs = db.executeQuery(selStr, withArgumentsIn: []) else {
            Log.print("db.executeQuery failed \(db.lastError())")
            return false
        }
        if rs.next() {
            cnt = rs.int(forColumn: "count")
            if cnt > 0 {
                retVal = true
            }
            else {
                retVal = false
            }
        }
        else {
            retVal = false
        }
        
        return retVal
    }
    
    func fillVerbArray() {
        Log.methodEnter()
        let start: TimeInterval = Date.timeIntervalSinceReferenceDate
        var whereClause: String!
        
        whereClause = selection.getWhereClause()
        
        let vrb_sel_mode = Params.shared.verbSelectMode
        switch vrb_sel_mode{
        case .use_all_verbs:
            Log.print("Using all verbs")

            let selAll = "SELECT count(*) as count FROM VERBS WHERE \(whereClause!) ;"
            Log.print("selAll = \(selAll)")
            if db == nil {
                Log.print("db is nil...")
                fatalError()
            }
            let rsAll: FMResultSet = db.executeQuery(selAll, withArgumentsIn: [])!
            
            var allVerbs: Int32 = 0
            if (rsAll.next()) {
                allVerbs = rsAll.int(forColumn: "count")
            }
            
            recordCount = allVerbs;
        case .use_verb_list:
            recordCount = 0;
            verbArray = Array()
            
//            selection.print();
            
            let selWhereClause = selection.getEndingAndTypeClauseOnly()
            var whClause = "SELECT count(*) as count FROM VERBS" + selWhereClause
            Log.print("selWhereClause = (selWhereClause)")
            if (selWhereClause.count == 0) {
                whClause += " WHERE ";
            }
            else {
                whClause += " AND "
            }
            
            Log.print("Whereclause = \(whClause)")
            var fullWhereClause = ""
            
            // FIX_ME: need to check to see if Params.shared.currentSelectedVerb is nil. If it
            // is, do something about it. Set to .use_all_ verbs? Dunno.
            guard let infinitives = Params.shared.currentSelectedVerblist?.infinitives else {
                Log.print("Got a nil when getting Params.shared.infinitives")
                return
            }

            for inf in infinitives {
                let infinitive = Utilities.escapeApostrophes(inputStr: inf)
                fullWhereClause = "\(whClause) infinitive = ?;"
            
                let rs4 = db.executeQuery(fullWhereClause, withArgumentsIn: [infinitive])
                if (rs4?.next())! {  // go through this only if the select statement returned a result set
                    
                    let verbCount = rs4?.int(forColumn: "count");
                    recordCount += verbCount!;
                    
                    self.verbArray += [infinitive]
                    
                }
            }
        case .use_one_verb:
            break
        }  // end switch
        verbArrayIsUpdated = true;
        
        let stop: TimeInterval = Date.timeIntervalSinceReferenceDate
            Log.print("Time in \(#function): \(stop-start)")
    

        
        //    int i = 1;
        //    for (NSString *v in self.verbArray) {
        //
        //        debugPrintArgs(@"%d: %@", i++, v);
        //
        //    }
        Log.print("recordCount: \(recordCount)")

        
        return
    }
    
    func calculateRecordCount() -> Int32 {
        Log.methodEnter()
        
        // tests to see if the current selection (verblists, verb settings) will return at least one verb form
        var countQuery: String = ""
        var whereClause: String = ""
//        var infClause = ""
        recordCount = 0
                
        whereClause = selection.getWhereClause()
        let mode = Params.shared.verbSelectMode
        switch mode {
            case .use_one_verb:
                if Params.shared.currentSelectedSingleVerbInfinitive == nil {
//                guard let inf = Params.shared.currentSelectedSingleVerbInfinitive else {
                    Params.shared.verbSelectMode = .use_all_verbs
                    return calculateRecordCount()
                }
//                if whereClause.count > 0 {
////                    whereClause = whereClause.replacingOccurrences(of: "WHERE ", with: "WHERE (")
//                    whereClause += " AND infinitive = '\(inf)'"
//
//                }
//                else  { // no where clause
//                    whereClause += " WHERE infinitive = '\(inf)'"
//                }
                countQuery = "SELECT count(*) as count FROM verbs \(whereClause);"
//                Log.print("countQuery: \(countQuery)")

//                guard let rs = db.executeQuery(countQuery, withArgumentsIn: nil) else {
//                    if let err = db.lastError() {
//                        Log.print("db.executeQuery failed \(err)")
//                    }
//                    else {
//                        Log.print("db.executeQuery failed, but db.lastError() returned nil.")
//                    }
//                    return 0
//                }

//                rs.next()
//                recordCount = rs.int(forColumn: "count")

            case .use_all_verbs:
                countQuery = " SELECT count(*) AS count FROM verbs \(whereClause);"
//                Log.print("countQuery: \(countQuery)")
//                guard let rs = db.executeQuery(countQuery, withArgumentsIn: nil) else {
//                    if let err = db.lastError() {
//                        Log.print("db.executeQuery failed \(err)")
//                    }
//                    else {
//                        Log.print("db.executeQuery failed, but db.lastError() returned nil.")
//                    }
//                    return 0
//                }
////               rs = db.executeQuery(countQuery, withArgumentsInArray: nil)
//                rs.next()
//                recordCount = rs.int(forColumn: "count")
            
            case .use_verb_list:
//                var records: Int32 = 0
                guard let vl = Params.shared.currentSelectedVerblist else {
                    Params.shared.verbSelectMode = .use_all_verbs
                    return calculateRecordCount()
                }
                currentVerbList = vl
                countQuery = " SELECT count(*) AS count FROM verbs \(whereClause);"
            }   // switch
        
        Log.print("countQuery: \(countQuery)")

        guard let rs = db.executeQuery(countQuery, withArgumentsIn: []) else {
            Log.print("db.executeQuery failed \(db.lastError())")
            return 0
        }
        rs.next()
        recordCount += rs.int(forColumn: "count")
        Log.print("recordCount = \(recordCount)")

    return recordCount
    }
    
    @objc func handleVerbListChange(notification: Notification) {
        Log.methodEnter()
        
        let mode = Params.shared.verbSelectMode
        switch mode {
            
        case .use_one_verb:
            guard let oneVerb = Params.shared.currentSelectedSingleVerbInfinitive else {
                Log.print("got a nil for Params.shared.currentSelectedSingleVerbInfinitive")
                Params.shared.verbSelectMode = .use_all_verbs
                return
            }
            currentVerbList.name = oneVerb
            currentVerbList.infinitives.removeAll(keepingCapacity: true)
            currentVerbList.infinitives.append(oneVerb)
            
        case .use_verb_list:
            guard let vl = Params.shared.currentSelectedVerblist else {
                Log.print("Got a nil when trying to get curentVerbList from Params")
                Params.shared.verbSelectMode = .use_all_verbs
                return
            }
            vl.retrieve()
//            fillVerbArray()
            
        case .use_all_verbs:
            break
            
        }
        _ = calculateRecordCount()
    }
    
    @objc func handleVerbSelectionModeChange(notification: Notification) {
        Log.methodEnter()
        
        var mode = Params.shared.verbSelectMode
        mode.retrieve()
        switch mode {
            
        case .use_one_verb:
            currentVerbList.name = Params.shared.currentSelectedSingleVerbInfinitive!
            currentVerbList.infinitives.removeAll(keepingCapacity: true)
            currentVerbList.infinitives.append(currentVerbList.name)
 
            break
            
        case .use_verb_list:
            currentVerbList = Params.shared.currentSelectedVerblist!
            break
        case .use_all_verbs:
            break
            
        }
        _ = calculateRecordCount()
    }
    
    @objc func handleVerbSettingChange(notification: Notification) {
        Log.methodEnter()
        
        var mode = Params.shared.verbSelectMode
        mode.retrieve()
        switch mode {
            
        case .use_one_verb:
            currentVerbList.name = UDefs.string(forKey: K.keySingleVerbSelected)!
            currentVerbList.infinitives.removeAll(keepingCapacity: true)
            currentVerbList.infinitives.append(UDefs.string(forKey: K.keySingleVerbSelected)!)
            
        case .use_verb_list:
            currentVerbList.name = UDefs.string(forKey: K.keyVerbListSelected)!
            currentVerbList.printYourself()
            currentVerbList.retrieve()
            
        case .use_all_verbs:
            break
            
        }
    _ = calculateRecordCount()
    }
    
    func handleTest(notification: Notification) {
        Log.print("handleTest fired")
    }

}
