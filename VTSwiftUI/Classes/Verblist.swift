//
//  Verblist.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/15/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

// July 2017: change: store verblists with the uuid as the file name, reather than the verb list name
import Foundation
import CloudKit

let keyData: String = "keyData"

//class Verblist: NSCopying {
class Verblist {
    
    var name: String {
        didSet {
            isDirty = true
        }
    }
    var modDateTime: Date!
    var infinitives: [String]
    var inCloud: Bool!
    var uuid: String!
    var displayStr: String {
        get {
            return name
        }
    }// no plist extension
    
    var fullPath: String { // includes full path and extension
        get {
            return FileUtilities.verbListDirectoryPath().stringByAppendingPathComponent(path: uuid)
        }
    }
    
    var fullURL: URL {
            get {
                return FileUtilities.verbListURL(uuid)
            }
        }// full path and extension
    
    var isDirty: Bool
    var isNew: Bool
    
    init () {
        name = ""
        infinitives = []
        isDirty = false
        isNew = true
        inCloud = false
        uuid = UUID().uuidString

    }
    
    convenience init(verblistname:String) {
        self.init()
        name = verblistname
    }
    
    convenience init(in_uuid:String) {
        self.init()
        uuid = in_uuid
    }

    
    func addVerb(verb: String) {
        let index = infinitives.index(of: verb)
        if index == nil {  // the verb is not in the infinitives array
            infinitives.append(verb)
            isDirty = true
        }
        
        // now sort the infinitives
        infinitives = infinitives.sorted() {$0 < $1 }
    }
    
    func removeVerb(verb: String) {
        let index = infinitives.index(of: verb)
        if index != nil {
            infinitives.remove(at: Int(index!))
            isDirty = true
        }
    }
    
    func contains(verb:String) -> Bool {
        for inf in infinitives {
            if inf.lowercased() == verb.lowercased() {
                return true
            }
        }
        return false
        
    }
    
    
    func save() {
        modDateTime = Date()
        saveLocally(dt: modDateTime)
//        if isNew {
//            createNewRecordInCloudKit(dt: modDateTime)
//        }
//        else {
//            updateRecordInCloudKit(dt: modDateTime)
//        }
//        return
    }

    //MARK: - local methods
    
    func saveLocally(dt: Date) {
        
        // if this record exists locally, delete it or the writeToFile will fail
        // create a mutable dictionary,then save it to the local veblist directory
        let fullPath = FileUtilities.verbListPath(file: uuid).stringByAppendingPathExtension(ext: ".verblist")
        let fileExists = FileManager.default.fileExists(atPath: fullPath!)
        if fileExists {
            do {
                try FileManager.default.removeItem(atPath: fullPath!)
            } catch let error as NSError {
                Log.print("\(String(describing: fullPath)) could not be removed: \(error.description)")
            }
        }

        let dic = NSMutableDictionary()
        dic.setValue(name, forKey: "name")
        dic.setValue(modDateTime, forKey: "modified_datetime")
        dic.setValue(infinitives, forKey: "infinitives")
        dic.setValue(uuid, forKey: "uuid")
        
//        let fpath = FileUtilities.verbListPath(file: name)
        dic.write(toFile: fullPath!, atomically: true)
        isDirty = false
        isNew = false
    }
    
    /**
     A placeholder so that verblist.retrieve statements don't fail
     */
    func retrieve() {
        retrieveLocally()
    }
    
    /**
     Retrieves the verblist from the local Documents/verblist directory
     - Parameter Must have the property uuid set
     */
    
    func retrieveLocally() {
        infinitives.removeAll()
        
        if let fpath = FileUtilities.verbListPath(file: uuid.stringByAppendingPathExtension(ext: "verblist")!) {
            let dic = NSMutableDictionary(contentsOfFile: fpath)
            
            for (key,_) in dic! {
                Log.print(key as! String)
            }
            if let inf = dic?.object(forKey: "infinitives") {
                infinitives = inf as! [String]
            }
            if let datetime = dic?.object(forKey: "modified_datetime") {
                modDateTime =  datetime as! Date
            }
            
            if let listname = dic?.object(forKey: "name") {
                name = listname as! String
            }
        }
        isDirty = false
        isNew = false
        infinitives = infinitives.sorted() {$0 < $1 }
    }

    
    
    public func existsOnCloudKit() -> Bool {
        var retVal: Bool = false
        CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus {
            case .restricted, .couldNotDetermine, .noAccount:
                break
                
            case .available:
                
                let db = CloudKitUtilities.getPrivateDatabase()
                let predicate = NSPredicate(format: "uuid == %@", argumentArray: [self.uuid])
                
                let query = CKQuery(recordType: "verblist", predicate: predicate)
                db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                    Log.errorMsg("post-query: existsOnCloudKit - verblist, got \(results!.count) result(s).")
                    if error != nil {
                        Log.print("error on query: \(String(describing: error?.localizedDescription))")
                    }
                    else {   //else 1
                        switch results!.count {
                        case 0: // not in CloudKit
                            retVal = false
                            break
                        case 1:
                            retVal = true
                        default:
                            Log.print("Got \(results!.count) records back from a query that should have returned only one record.")
                            break
                        }// switch
                    }  // else 1
                } // query closure block
            } // if available
        }
        return retVal
    }
    
    func retrieveFromCloudKit() {
        CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus {
            case .restricted, .couldNotDetermine, .noAccount:
                break
                
            case .available:

                let db = CloudKitUtilities.getPrivateDatabase()
                let predicate = NSPredicate(format: "uuid == %@", argumentArray: [self.uuid])
                
                let query = CKQuery(recordType: "verblist", predicate: predicate)
                db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                    Log.errorMsg("post-query: retrieveFromCloudKit - verblist, got \(results!.count) result(s).")
                    if error != nil {
                        Log.print("error on query: \(String(describing: error?.localizedDescription))")
                    }
                    else {   //else 1
                        switch results!.count {
                        case 0: // not in CloudKit
                            break
                        case 1:
                            let record = results!.first! as CKRecord
                            self.name = record.object(forKey: "name") as! String
                            self.uuid = record.object(forKey: "uuid") as! String
                            self.modDateTime = record.object(forKey: "modified_datetime") as! Date
                            self.infinitives = record.object(forKey: "infinitives") as! [String]
//                            for inf in tmpArray {
//                                Log.print("infinitive: \(inf)")
//                                self.infinitives.append(inf as! String)
                            self.isDirty = false
                            self.isNew = false
                            self.inCloud = true
                            self.infinitives = self.infinitives.sorted() {$0 < $1 }
                                
//                            }
                        default:
                            Log.print("Got \(results!.count) records back from a query that should have returned only one record.")
                            break
                        }// switch
                    }  // else 1
            } // query closure block
        } // if available
    }
    }
    
    
    func retrieveFromCloudAndSaveLocally() {
        infinitives.removeAll(keepingCapacity: false)
        retrieveFromCloudKit()
        save()


    }
    
    func retrieveLocallyAndSavetoCloud() {
        retrieveLocally()
        save()
    }
    
    
    //MARK: - CloudKit methods
       
    
    func createNewRecordInCloudKit(dt: Date) {
        Log.methodEnter()
        CKContainer.default().accountStatus() { (accountStatus, error) in
        switch accountStatus {
        case .restricted, .couldNotDetermine, .noAccount:
            break
            
        case .available:
                let db = CloudKitUtilities.getPrivateDatabase()
                let verbID = CKRecord.ID(recordName: self.uuid)
                
                let predicate = NSPredicate(format: "uuid == %@", argumentArray: [self.uuid]) // gets                 let query = CKQuery(recordType: "verblist", predicate: predicate)
                let query = CKQuery(recordType: "verblist", predicate: predicate)
                db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                    Log.errorMsg("post-query: createNeswRecordOnCloudkit, got \(results!.count) result(s).")
                    if error != nil {
                        Log.print("error on query: \(String(describing: error?.localizedDescription))")
                    }
                    else {
                        switch results!.count {
                        case 0:  // doesn't exist in CloudKit
                            let verbListRecord = CKRecord(recordType: "verblist", recordID: verbID)
                            verbListRecord.setObject(self.name as CKRecordValue?, forKey: "name")
                            verbListRecord.setObject(self.infinitives as CKRecordValue?, forKey: "infinitives")
                            verbListRecord.setObject(self.modDateTime as CKRecordValue?, forKey: "modified_datetime")
                            verbListRecord.setObject(self.uuid as CKRecordValue?, forKey: "uuid")
                            db.save(verbListRecord, completionHandler: {(record, error) -> Void in
                                if error != nil {
                                    let s = error?.localizedDescription
                                    Log.print("Error saving '\(self.name)' to CloudKit: \(String(describing: s))")
                                }
                            })
                            break
                            
                        case 1:
                            let verbListRecord = results!.first! as CKRecord
                            verbListRecord.setObject(self.name as CKRecordValue?, forKey: "name")
                            verbListRecord.setObject(self.infinitives as CKRecordValue?, forKey: "infinitives")
                            verbListRecord.setObject(self.modDateTime as CKRecordValue?, forKey: "modified_datetime")
                            verbListRecord.setObject(self.uuid as CKRecordValue?, forKey: "uuid")
                            db.save(verbListRecord, completionHandler: {(record, error) -> Void in
                                if error != nil {
                                    let s = error?.localizedDescription
                                    Log.print("Error saving '\(self.name)' to CloudKit: \(String(describing: s))")
                                }
                            })
                            break
                        default:
                            Log.print("error - got \(results!.count) records.")
                        }  // switch count
                    }// else
                }  // db.perform
                

                Log.print("Adding '\(self.name)' to verblist")
            } // if
        
        }//        createNewMetaDataRecord(db)
    }
    
    func updateRecordInCloudKit(dt: Date) {
        CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus  {
            case .restricted, .noAccount, .couldNotDetermine:
                break
            case .available:
                let db = CloudKitUtilities.getPrivateDatabase()
                let predicate = NSPredicate(format: "uuid == %@", argumentArray: [self.uuid])
                
                let query = CKQuery(recordType: "verblist", predicate: predicate)
                db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                    Log.errorMsg("post-query: updateRecordInCloudKit, got \(results!.count) result(s).")
                    if error != nil {
                        Log.print("error on query: \(String(describing: error?.localizedDescription))")
                        }
                    else {
                        switch results!.count {
                        case 0:
                            break
                        case 1:
                            let verbListRecord = results!.first! as CKRecord
                            verbListRecord.setObject(self.name as CKRecordValue?, forKey: "name")
                            verbListRecord.setObject(self.infinitives as CKRecordValue?, forKey: "infinitives")
                            verbListRecord.setObject(self.modDateTime as CKRecordValue?, forKey: "modified_datetime")
                            verbListRecord.setObject(self.uuid as CKRecordValue?, forKey: "uuid")
                            db.save(verbListRecord, completionHandler: {(record, error) -> Void in
                                if error != nil {
                                    let s = error?.localizedDescription
                                    Log.print("Error saving '\(self.name)' to CloudKit: \(String(describing: s))")
                                }
                            })
                            
                            // now do a metadata update
                            
                        default:
                            Log.print("error - got \(results!.count) records.")
                        } // switch
                    } // else
                    
                }  // closure
            } // switch
        } // accountStatusWithCompletionHandler() closure
    }

    func deleteLocally() {
        let fm = FileManager.default
        do {
            try fm.removeItem(atPath: fullPath)
        } catch let error as NSError {
            Log.print("Error: \(error.domain): \(error.description) for \(fullPath)")
        }
    }

    func deleteFromCloudKit() {
        CKContainer.default().accountStatus() { (accountStatus, error) in
            switch accountStatus  {
            case .restricted, .noAccount, .couldNotDetermine:
                break
            case .available:
                let container = CKContainer.default()
                let db = container.privateCloudDatabase
                let pred = NSPredicate(format: "uuid == %@", argumentArray: [self.uuid]) // gets all records in
                let query = CKQuery(recordType: "verblist", predicate: pred)
                db.perform(query, inZoneWith: nil) {(results, error) -> Void in
                    if error != nil {
                        Log.errorMsg("error with query: desc:\(String(describing: error?.localizedDescription))")
                    }
                    else {
                        let record = results!.first
                        let recordID = record?.recordID
                        db.delete(withRecordID: recordID!) {returnRecord, error in
                            if let err = error {
                                    Log.print("Delete Error: \(err.localizedDescription)")
                                
                                }
                        }
                    } // else
                }
            } // switch
        } // CKContainer.defaultContainer().accountStatusWithCompletionHandler() closure
    }
    
    func delete() {
        deleteLocally()
//        deleteFromCloudKit()
    }
    
    func print() {
        Log.print("verblist:")
        Log.print("   name: \(name)")
        Log.print("   displayStr: \(displayStr)")
        Log.print("   uuid: \(uuid)")
//        Log.print("   fullPath: \(fullPath)")
//        Log.print("   fullURL: \(fullURL)")
        Log.print("   isDirty: \(isDirty)")
        Log.print("   isNew: \(isNew)")
        if infinitives.count == 0 {
            Log.print("Zero infinitives")
        }
        else {
            for inf in infinitives {
                Log.print("   \(inf)")
            }
        }
    }
    
//    func copy(with zone: NSZone? = nil) -> Any {
//        let copy = Verblist(in_uuid: uuid)
//        copy.name = name
//        for f in infinitives {
//            copy.infinitives.append(f)
//        }
//        copy.isDirty = false
//        return copy
//    }

    func xxx() -> String {
        return "something"
    }

}
