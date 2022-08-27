//
//  Selection.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/16/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Selection {
    var delegate: AppDelegate!
    var db: FMDatabase!
    public var verbStates: [String: VerbState] = [:]
    var tenseNumbers: [String: Int] = [:]
    var whereClauseUpdated: Bool = false
    var whereClause: String = ""
    var dirty = false
    
//    var dictForNSData: NSMutableDictionary;
    
    init() {
//        delegate = UIApplication.sharedApplication().delegate as AppDelegate
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleVerbStateChange"), name: keyVerbStateChanged, object: nil)
//        NotificationCenter.defaul.addObserver(self, selector: #selector(self.handleVerbStateChange), name: keyVerbStateChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleVerbSettingChange), name: NSNotification.Name(rawValue: notification_verbSettingsChange), object: nil)
        
        db = FileUtilities.openSettingsDatabase()
    }
    
    func createVSDictionary(index: Int, value: Int, stop: inout Bool) -> Void {
        Log.print("index: \(index), value: \(value)")
        
    }
    
    @objc private func handleVerbSettingChange(notification: NSNotification) {
        Log.methodEnter()
        let userInfo = notification.userInfo
        guard let changedStates = userInfo?["NSUbiquitousKtoreChangedKeysKey"] else {
            Log.print("userInfo is nil!")
            return
        }
        for state in changedStates as! [String] {
            Log.print("Changing state: \(state)")
            // get the value from JzUserDefaults
            guard let newState = UDefs.bool(forKey: state) else {
                return
            }
            setState(setting_name: state, value: newState)
            
        }
        Log.print("\(String(describing: userInfo))")
        
        
    }
    
 
    
    func setState(setting_name: String, value: Bool) {
        
        // update the verbstates dictionary entry for this verbstate
        guard let vs: VerbState = verbStates[name] else { return }
        vs.verbState = value
        updateSettingsInJzUserDefaults(settingName: name, settingValue: value)
        dirty = true
        
        switch vs.verbType {
            case "simple":
            // if this is All Simple, set all the simple tense subtypes to this value
            if name.lowercased() == "all simple tenses" {
                for (_, vs) in verbStates {
                    if vs.verbSubType.lowercased() == "simple" && vs.verbState != value  {
                        vs.verbState = value
                    }
                }
            }
            else {  // else this is not a change to "all simple tenses"
            // if any simple tenses are turned off, turn off the All Simple Tenses
                var onState = true
                var changed = true
                for (_, vs) in verbStates {
                    if vs.verbSubType.lowercased() == "simple" && vs.verbState == OFF {
                        onState = false
                        changed = true
                    }
                }
                if changed {
                    let vs: VerbState = verbStates["All Simple Tenses"]!
                    vs.verbState = onState ? ON : OFF
//                    updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: vs.verbState)
                }
            }
            break
            
            case "compound":
                // if this is All Compound, set all the Compound subtypes to this value
                if name.lowercased() == "all compound tenses" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "compound" && vs.verbState != value {
                            vs.verbState = value
//                            updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: value)
                        }
                    }
                }
                else {
                    // do something with compound tenses
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "compound" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let vs = verbStates["All Compound Tenses"]!
                        vs.verbState = onState ? ON : OFF
//                        updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: vs.verbState)
                    }
                }

            break
            case "type":
                // if this is all types, set all the all types subtypes to this value
                if name.lowercased() == "all verb types" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "type" && vs.verbState != value {
                            vs.verbState = value
//                            updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: value)
                        }
                    }
                }
                else {
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "type" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let vs = verbStates["All Verb Types"]!
                        vs.verbState = onState ? ON : OFF
//                        updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: vs.verbState)
                    }
                    
                    
                }

            break
            case "ending":
                // if this is all endings, set all the all ending subtypes to this value
                if name.lowercased() == "all verb endings" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "ending" && vs.verbState != value {
                            vs.verbState = value
//                            updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: value)
                            
                        }
                    }
                }
                else {
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        //            Log.print("vs.name:\(vs.name), vs.verbSubType: \(vs.verbSubType): state: \(vs.verbState)")
                        if vs.verbSubType.lowercased() == "ending" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let vs = verbStates["All Verb Endings"]!
                        vs.verbState = onState
//                        updateSettingsInJzUserDefaults(settingName: vs.name, settingValue: vs.verbState)
                    }

                }

            break
            case "person":
                // if this is all types, set all the all types subtypes to this value
                if name.lowercased() == "all persons/numbers" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "person" && vs.verbState != value {
                            vs.verbState = value
//                            updateSettingsInJzUserDefaults(settingName: name, settingValue: value)
                        }
                    }
                }
                else {
                    var changed = false
                    var onState = true
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "person" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let updateVs = verbStates["All Persons/numbers"]!
                        updateVs.verbState = onState
//                        updateSettingsInJzUserDefaults(settingName: updateVs.name, settingValue: updateVs.verbState)
                    }
                }
                
            break
        default:
            Log.print("Got an invalid subtype: \(vs.verbSubType)")
        
        }
        UDefs.set(value: vs.verbState, forKey: vs.name)
       
        NotificationCenter.default.post(name: .notification_selectionVerbStateChanged, object: nil)
        
        
        
       
        // now set the verbupdateflag to no
        whereClauseUpdated = false
        
    }
    
    func getState(setting_name: String) -> Bool {
        if name == "" {
            return false
        }
        let vs: VerbState = verbStates[name]!
        return vs.verbState
    }
    
    func getWhereClause() -> String {
//        self.print()
        
        if !whereClauseUpdated {
            var clause: String = ""
            let tenseStr = getTenseStr()
            let endingStr = getEndingStr()
            let typeStr = getTypeStr()
            let personStr = getPersonStr()
            let reflexiveStr = getReflexiveStr()
            
            if tenseStr.length == 0 && endingStr.length == 0 && typeStr.length == 0 && personStr.length == 0 {
                return ""
            }
            else {
                var needAnd = false
                if tenseStr.length > 0 {
                    clause += tenseStr
                    needAnd = true
                }
                if endingStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += endingStr
                    needAnd = true
                }
                if typeStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += typeStr
                    needAnd = true
                }
                if personStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += personStr
                }
                if reflexiveStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += reflexiveStr
                }
            }
            
            if clause.length > 0 {
                clause = " WHERE " + clause
            }
        whereClauseUpdated = true
        whereClause = clause
        return clause
        }
        else {
            return whereClause
        }
        
    }
    
    func getReflexiveStr() -> String {
        if getState(setting_name: "Reflexive") == OFF {
            return " reflexive = 0 "
        }
        else {
            return ""
        }
        
    }
    func getTenseStr() -> String {
        var str: String = ""
        var needOr = false
        
        if getState(setting_name: "All Simple Tenses") == ON && getState(setting_name: "All Compound Tenses") == ON {
            return ""
        }
        
        for (name, vs) in verbStates {
            if (vs.verbType == "simple" || vs.verbType == "compound") && vs.summary == false {
                if vs.verbState == ON {
                    if needOr {
                        str += " OR "
                    }
                    // get the number for this tense
                    let tenseNumber = tenseNumbers[name]!
                    str = str + " tense = \(tenseNumber)"
                    needOr = true
                }
            }
        }
        if str.length > 0 {
            str = " (\(str)) "
        }
        return str
    }

    func getEndingStr() -> String {
        var str: String = ""
        var needOr = false
        
        if getState(setting_name: "All Verb Endings") == ON {
            return ""
        }
        
        for (_, vs) in verbStates {
            if vs.verbType == "ending" && vs.summary == false {
                if vs.verbState == ON {
                    if needOr {
                        str += " OR "
                    }
                    str += " ending = '\(vs.name)' "
                    needOr = true
                }
            }
        }
        if str.length > 0 {
            str = " (\(str)) "
        }
        return str
    }
    
    func getPersonStr() -> String {
        var personStr = ""
        var needOr: Bool = false
        
        let vsState: VerbState = self.verbStates[kAllPersons]!
        if vsState.verbState == OFF {  // not all verb types have been selected
            if self.getState(setting_name: kPerson1) == ON {
                personStr = " (genericnumber2 = 1) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson2) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 2) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson3) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 3) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson4) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 4) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson5) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 5) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson6) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 6) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson7) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 7) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson8) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 8) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson9) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 9) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson10) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 10) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson11) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 11) ";
                needOr = true;
            }
            
            if self.getState(setting_name: kPerson12) == ON {
                if needOr == true {
                    personStr += " OR "
                }
                personStr += " (genericnumber2 = 12) ";
                needOr = true;
            }

      }
        if personStr.length > 0 {
            personStr = " (\(personStr)) "
        }

        return personStr;
        
    }
    
    func getTypeStr() -> String {
        var str: String = ""
        var needOr = false
        
        if getState(setting_name: "All Verb Types") == ON {
            return ""
        }
        
        
        // need to look at each individually,  ecause stem-changing and ortho-changing will not work in the query
        // cound lowercase everything and remove the hyphen
        // best thing would be to change the database back to original
        // also need to figure out what to do with use vosotros
        for (_, vs) in verbStates {
            if vs.name.contains("vosotros") == false {
                if vs.verbType == "type" && vs.summary == false {
                    if vs.verbState == ON {
                        if needOr {
                            str += " OR "
                        }
                        let vsname = vs.name.lowercased().replace(target: "-", withString: "")
                        str = str + " \(vsname) = 1 "
                        needOr = true
                    }
                }
            }
        }
        if str.length > 0 {
            str = " (\(str)) "
        }
        return str
    }
    
    func getEndingAndTypeClauseOnly() -> String {
        let endingStr = getEndingStr()
        let typeStr = getTypeStr()
        var needAnd = false
        var retStr = ""
        
        if (endingStr.length == 0 && typeStr.length == 0) {
            return retStr
        }
        
        if (typeStr.length > 0) {
            retStr = typeStr
            needAnd = true
        }
        
        if (endingStr.length > 0) {
            if (needAnd == true) {
                retStr = retStr + " AND "
            }
            retStr += endingStr
        }
        
        if (retStr.length > 0) {
            retStr = " WHERE " + retStr
        }
        
        return retStr
        }



    func populate() {
        // open the settings database we'll need it no matter what
        guard let db = FileUtilities.openAppSettingsDatabase() else {
        Log.print("Could not open settingsDatabase")
        return
        }
        
        // process is this:
        // get everything from the local verbsetting database
        // if iCloud is available,
        //      update the local values from the iCloudKit
        //      update the local database
        // but... what if the local values are more recent than the Cloud values. I have no way to know that.
        var sqlStr = "SELECT * FROM verbsettings;"
        guard let rs: FMResultSet = db.executeQuery(sqlStr, withArgumentsIn: nil) else {
            Log.print("db.lastError: \(db.lastError())")
            assert(1 == 2)
            return
        }
        while rs.next() {
            let vs: VerbState = VerbState()
            vs.name = rs.string(forColumn: "setting_name")
            vs.verbState = rs.bool(forColumn: "setting_state")
            vs.verbType = rs.string(forColumn: "setting_type")
            vs.verbSubType = rs.string(forColumn: "setting_subtype")
            vs.viewRow = rs.int(forColumn: "viewrow")
            vs.summary = rs.bool(forColumn: "summary")
            
            if let verbState = UDefs.bool(forKey: vs.name) {
                vs.verbState = verbState
            }
            else {
                vs.verbState = true
            }
            verbStates[vs.name] = vs
        }
         CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus {
            case .restricted, .couldNotDetermine, .noAccount:
                // iCLoud not available, so get everything from local
                break
                
            case .available:
                // icloud available so update user defaults from there
                self.updateSelectionsFromCloudKit()
            }
        }
        
            sqlStr = "SELECT setting_name, tense FROM verbsettings WHERE tenseNumber > 0;"
            guard let rs1 = db.executeQuery(sqlStr, withArgumentsIn: nil) else {
                Log.print("db.executeQuery failed with error \(db.lastError())")
                return
            }
        while rs1.next() {
            let tenseName = rs1.string(forColumn: "setting_name")
            let tenseNumber = Int(rs1.int(forColumn: "tenseNumber"))
            self.tenseNumbers[tenseName!] = tenseNumber
        }
    }

    func updateSelectionsFromCloudKit() {
        let db_cloudkit = CloudKitUtilities.getPrivateDatabase()
        for (vsName, _) in self.verbStates {
            let predicate = NSPredicate(format: "setting_name == %@", argumentArray: [vsName])
            let query = CKQuery(recordType: "user_setting_numeric", predicate: predicate)
            db_cloudkit.perform(query, inZoneWith: nil) {(results, error) -> Void in
                Log.errorMsg("post-query: user_settings_numeric, got \(results!.count) result(s).")
                if error != nil {
                    Log.print("error on query: \(String(describing: error?.localizedDescription))")
                }
                else {  // no error
                    if results!.count == 0 {
                        Log.print("Did not get a record when querying \(vsName)")
                    }
                    else { // returned one record
                        // got something
                        let record = results!.first! as CKRecord
                        
                        let vState = record.object(forKey: "setting_name") as! Bool
                        let vSetting = record.object(forKey: "setting_value") as! String
                        Log.print("record retrieved from CloudKit: asked for: \(vsName); returned \(vSetting) state: \(vState)")
                        self.verbStates[vsName]?.verbState = vState                     }
                } // else returned one record
            } //  closure for db.performQuery(query, inZoneWithID: nil)
           
        } //        for (vsName, vState) in self.verbStates
//        saveToDatabase()
    } //func updateSelectionsFromCloudKit()
   
    func saveToUserDefaults() {
        for (_, vs) in verbStates {
            UDefs.set(value: vs.verbState, forKey: vs.name)
        }
    }
    
    func saveToICloud() {
        for (_, vs) in verbStates {
            UDefs.set(value: vs.verbState, forKey: vs.name)
        }
    }
    func saveOnCloudKit() {
        Log.methodEnter()
        if dirty == false {
            return
        }
        dirty = false
        CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus {
            case .restricted, .couldNotDetermine, .noAccount:
                break
                
            case .available:
                let db = CloudKitUtilities.getPrivateDatabase()
                for (vsName, vState) in self.verbStates {
                    let predicate = NSPredicate(format: "setting_name == %@", argumentArray: [vsName])
                    let query = CKQuery(recordType: "user_settings_numeric", predicate: predicate)
                    db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                        Log.errorMsg("post-query: user_settings_numeric: saveOnCloudKit, got \(results!.count) result(s).")
                        if error != nil {
                            Log.errorMsg("error on query: \(String(describing: error?.localizedDescription))")
                        }
                        else {  // no error
                            if results!.count == 0 {
                                let record = CKRecord(recordType: "user_setting_numeric", recordID: CKRecord.ID(recordName: vsName))
                                record.setObject(vState.verbState as CKRecordValue?, forKey: "setting_name")
                                record.setObject(vState.name as CKRecordValue?, forKey: "setting_value")
                                db.save(record, completionHandler: {(record, error) -> Void in
                                    if error != nil {
                                    let s = error?.localizedDescription
                                    Log.errorMsg("Error creating '\(vsName)' to CloudKit: \(String(describing: s))")
                                    }
                                })
                            }
                            else { // returned one record
                            // got something
                            let record = results!.first! as CKRecord
                            record.setObject(vState.verbState as CKRecordValue?, forKey: "user_setting_numeric")
                            db.save(record, completionHandler: {(record, error) -> Void in
                            if error != nil {
                                let s = error?.localizedDescription
                                Log.errorMsg("Error saving '\(vsName)' to CloudKit: \(String(describing: s))")
                            }
                                
                                // save it to the settings database
                            self.db.executeUpdate("UPDATE verbsettings SET setting_state = ? WHERE setting_name = ?; ", withArgumentsIn: [vState, vsName])
                        })
                       }
                    }
              } //  closure for db.performQuery(query, inZoneWithID: nil)
            
        }//   for (vsName, vState) in self.verbStates
        
        } // switch
        } // db.query closure
    }
    
//    func saveOnCloud() {
//        // first, build an nsdictionary.
//        // key is the verbstate
//        // object is the boolean associated with the verbstate
//        let states: NSMutableDictionary = NSMutableDictionary(capacity: 45)
//        
//        for (key, val) in verbStates {
//            Log.print("key: \(key), value; \(val.name)")
//            states.setObject(val.name, forKey: key)
//        }
//        
//        // archive it to nsData
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//        archiver.encodeObject(states, forKey: keyData)
//        archiver.finishEncoding()
//        
//        // write to the loal verblist directory
//        let archive: NSData = NSKeyedArchiver.archivedDataWithRootObject(states)
//        
//        // below was used fpr iCloud framework. Replaced by code below to use CloudKit
//        iCloud.sharedCloud().saveAndCloseDocumentWithName("verb_settings.data", withContent: archive, completion: {(cloudDocument,  documentData, error) in
//            Log.print("saved verb_settings.data")
//        })
//        // end of iCloud save
//        
//    }
//
//    
//    func saveToICloud() {
//        // build an NSArray
//        let arr = NSMutableArray()
//        for (_, vs) in verbStates {
//            arr.add(vs.saveForICloud())
//        }
//        
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWith: data)
//        archiver.encode(arr, forKey: keyData)
//        archiver.finishEncoding()
//        
//        let archive: NSData = NSKeyedArchiver.archivedDataWithRootObject(withRootObject: arr)
////            archive.writeToURL(localURL, atomically: true)
//        let i_cloud = iCloud.sharedCloud() as! iCloud
////
//        i_cloud.saveAndCloseDocumentWithName("verb_settings", withContent: archive, completion: {
//                (document: UIDocument!, data: NSData!, error: NSError!) in
//                if error != nil {
//                    Log.print("Error: \(error.description)")
//                }
//                
//            })
//        }
    
    private func updateSettingsInJzUserDefaults(settingName: String, settingValue: Bool) {
        UDefs.set(value: settingValue, forKey: settingName)  // problem here, in that this triggers a settignscChangenotification, which starts the process all over again
        self.saveOneSettingOnCloudKit(settingName: settingName)

    }
    
    private func saveOneSettingOnCloudKit(settingName: String) {
        Log.methodEnter()
        CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus {
            case .restricted, .couldNotDetermine, .noAccount:
                break
                
            case .available:
                guard let vs = self.verbStates[settingName] else {
                    return
                }
                let db = CloudKitUtilities.getPrivateDatabase()
                let predicate = NSPredicate(format: "setting_name == %@", argumentArray: [vs.name])
                let query = CKQuery(recordType: "user_setting_numeric", predicate: predicate)
                db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                    Log.errorMsg("post-query: user_settings_numeric, got \(results!.count) result(s).")
                    if error != nil {
                        Log.errorMsg("error on query: \(String(describing: error?.localizedDescription))")
                    }
                    else {  // no error
                        // got something
                        let record = results!.first! as CKRecord
                        record.setObject(vs.verbState as CKRecordValue?, forKey: "selection_setting")
                        db.save(record, completionHandler: {(record, error) -> Void in
                        if error != nil {
                            let s = error?.localizedDescription
                            Log.errorMsg("Error saving '\(vs.name)' to CloudKit: \(String(describing: s))")
                        }
                        })
//                        self.db.executeUpdate("UPDATE verbsettings SET setting_state = ? WHERE setting_name = ?; ", withArgumentsIn: [vs.verbState, vs.name])

                    }
                } //  closure for db.performQuery(query, inZoneWithID: nil)
                    
            } // switch
        } // db.query closure
    }

    func retrieveFromCloudKit () {
        // retrieve each verbstate from the selections database
        // then, in the back ground,
        //  retrieve from cloudKit each verbstate
        //  update the verbstate
        //  update the selection database
    }
    
    func printYourself() {
        Log.print("Selection:")
        for (_, vs) in verbStates {
            Log.print("  \(vs.name) = \(vs.verbState)")
        }

    }
    
    
}

/* 
 When do we get the settings from CloudKit?
 When do we update cloudkit, database, user defaults (ubiquityContainer and userDefaults.standard?)
 CloudKit settings records and Settings database must be in sync
 
 Update userDefaults.standard from CloudKit on appDelegate.didFinishLaunchingWithOptions
 Update database from userDefaults.standard
 When a setting changes, update CloudKit and update UbiquityContainer and userDefaults.dtandard and database. This will trigger an iCloud notification.
 
 On receiving and iCloud notification, update ubiquityContainer and userDefaults.standard and database
 
 On closeout, update CloudKit and database
 */
