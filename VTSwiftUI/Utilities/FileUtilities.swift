//
//  FileUtilities.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 8/15/14.
//  Copyright (c) 2014 verbtrainers. All rights reserved.
//

import Foundation
import UIKit
import FMDB

//import Zip

enum databases {
    case settings
    case verbs
}


class FileUtilities {
    
    class func createVerbListDirectory () {
        var error: NSError?
        let documentsDirectory = FileUtilities.documentsDirectory()
        let verbListPath: String = documentsDirectory + "/verblists"
        do {
            try FileManager.default.createDirectory(atPath: verbListPath, withIntermediateDirectories: true, attributes: nil)
        } catch let error1 as NSError {
            error = error1
        }
        if let actualError = error {
            Log.print("An Error Occurred: \(actualError)")
        }
    }
    

    
    class func verblistDirectoryURL() -> URL {
        return URL(fileURLWithPath: FileUtilities.verbListDirectoryPath())
        
    }
    
    class func verbListDirectoryPath() -> String {
//        _: NSError?
        let documentsDirectory = FileUtilities.documentsDirectory()
        let path = documentsDirectory + "/verblists"
        let exists: Bool = FileManager.default.fileExists(atPath: path)
        if exists {
            return path
        }
        else {
            Log.print("\(path) does not exist")
            return "No verbListDirectory"
        }

    }
    
    
    class func verbListPath() -> String {
        return FileUtilities.verbListDirectoryPath()
    }
    class func verbListPath(file: String) -> String! {
        return FileUtilities.verbListDirectoryPath().stringByAppendingPathComponent(path: file)
    }
    
    class func verbListURL( _ file: String) -> URL {
        return FileUtilities.verblistDirectoryURL().appendingPathComponent(file).appendingPathExtension("verblist")
    }
    
    class func documentsDirectory() -> String {
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
        let docDir = dirs.object(at: 0) as! String
        Log.print("documentsDirectory: \(docDir)")
        return docDir

    }
    
    class func documentsDirectoryURL() -> URL {
        return URL(fileURLWithPath: FileUtilities.documentsDirectory())
    }
        
    class func resourceDirectory() -> String {
        let returnStr = Bundle.main.resourcePath;
        return returnStr!;
    }
    
    class func resourceDirectoryURL() -> URL {
        return URL(fileURLWithPath: FileUtilities.resourceDirectory())
    }
    
    
    class func settingsDatabaseURL() -> URL {
        let docDirURL = FileUtilities.documentsDirectoryURL()
        return docDirURL.appendingPathComponent(LanguageGlobals.settingsDatabaseName)
    }
    
    class func settingsDatabasePath() -> String {
        Log.print(settingsDatabaseURL().path)
        return settingsDatabaseURL().path
        }
    
    class func verbDatabaseURL() -> URL {
        var verbDatabaseDirURL = FileUtilities.documentsDirectoryURL()
        verbDatabaseDirURL = verbDatabaseDirURL.appendingPathComponent(LanguageGlobals.verbDatabaseName)
        if FileManager.default.fileExists(atPath: verbDatabaseDirURL.path) == false { // didn't find verbdatabase in documents, use the one in resources
            verbDatabaseDirURL = URL(fileURLWithPath: FileUtilities.resourceDirectory()).appendingPathComponent(LanguageGlobals.verbDatabaseName)
        }
        Log.print("verbDatabaseDirURL: \(verbDatabaseDirURL)")
        return verbDatabaseDirURL;
    }
    
    class func verbDatabasePath() -> String {
        return FileUtilities.verbDatabaseURL().path
    }
    
    class func doesHistoryDatabaseExist() -> Bool {
        var retBool = false
        let historyFile = FileUtilities.documentsDirectory().stringByAppendingPathComponent(path: "QuizHistories.sqlite3")
        let fm = FileManager.default
        retBool = fm.fileExists(atPath: historyFile)
        
        return retBool
        
    }
    
    class func historyFileDirectory() -> String {
        return FileUtilities.documentsDirectory()
    }
    
    class func openQuizHistoryDatabase() -> FMDatabase? {
        let dbPath = FileUtilities.documentsDirectory().stringByAppendingPathComponent(path: "QuizHistories.sqlite3")
        let exist = FileManager.default.fileExists(atPath: dbPath)
        if exist {
            let db = FMDatabase(path: dbPath)
            db.open()
            return db
        }
        else {
            return nil
        }

    }
    
//    class func createQuizHistoriesDatabaseIfNecessary() -> Bool {
//        let _ = FileUtilities.documentsDirectory().stringByAppendingPathComponent(path: "QuizHistories.sqlite3")
////        if FileManager.default.fileExists(atPath: path) {
////            Log.print ("QuizHistories.sqlite3 already exists.")
////            return true
////        }
//        // must not exist, create the database
//        let db = DB.shared.historyDB
//        if db.executeUpdate("CREATE TABLE IF NOT EXISTS quiz_histories (date_time text NOT NULL, right integer, wrong integer);" , withArgumentsIn: []) == false {
//            Log.print("Could not create the table.")
//            return false
//        }
//        else {
//            // read the quizhistories data. extract and convert the histories to sql and insert
//            let fm = FileManager.default
//            let quizHistoriesPath = FileUtilities.documentsDirectory().stringByAppendingPathComponent(path: "quizHistories.data")
//            if fm.fileExists(atPath: quizHistoriesPath) {
//                // get the quiz histories
//                let quizHistoriesData = try? Data(contentsOf: URL(fileURLWithPath: quizHistoriesPath))
//                if quizHistoriesData != nil {
//                    let rawArray = NSKeyedArchiver.unarchivedArrayOfObjects(ofClass: <#T##DecodedObject#>, from: quizHistoriesData)
//                    let rawArray = NSKeyedUnarchiver.unarchiveObject(with: quizHistoriesData!) as! NSArray
//                    for oneHistory in rawArray {
//                        // parse the history string
//                        Log.print("quizHistory: \(oneHistory)")
//                        let str = oneHistory as! String
//                        let date_time = String(str.prefix(19))
//                        
//                        var indexStartOfText = str.index(str.startIndex, offsetBy: 0)
//                        var indexEndOfText = str.index(str.endIndex, offsetBy: -31)
//                        
//                        // Swift 4
//                        var substring1 = String(str[..<indexEndOfText])
//                        
//                        indexStartOfText = str.index(str.startIndex, offsetBy: 19)
//                        indexEndOfText = str.index(str.endIndex, offsetBy: -20)
//                        substring1 = String(str[indexStartOfText..<indexEndOfText]).trimmingCharacters(in: .whitespacesAndNewlines)
//                        let right = Int(substring1)
//                        
//                        indexStartOfText = str.index(str.startIndex, offsetBy:30)
//                        indexEndOfText = str.index(str.endIndex, offsetBy: -6)
//                        substring1 = String(str[indexStartOfText..<indexEndOfText]).trimmingCharacters(in: .whitespacesAndNewlines)
//                        let wrong = Int(substring1)
//                        
//                        let sqlStr = "INSERT OR REPLACE INTO quiz_histories VALUES ('\(date_time)', \(right!), \(wrong!));"
//                        if db.executeUpdate(sqlStr, withArgumentsIn: []) == false {
//                            Log.print("Failed")
//                        }
//                        else {
//                            Log.print("Succeeded")
//                        }
//                    }
//                    
//                }
//            }
//        }  // else
//        
//        return true
//    }
    

    /* returns a list of all the verb lists located in the documents/verblists directory
        list contains only the verb listg names, without the extension
     */
    
    class func getVerbListNames()-> Array<String> {
        var lists: [String]
        lists = Array()
        
        let listDir = FileUtilities.verbListDirectoryPath()
        do {
            let pathList = try FileManager.default.contentsOfDirectory(atPath: listDir)
            for vl in pathList {
                // remove the .verblist extension so we return only the verblist
                lists.append(vl.stringByDeletingPathExtension)
            }
        } catch let error as NSError {
            Log.errorMsg("error getting verblists \(error.description)")
        }
        
        return lists
    }

    
    class func getVerbListPaths()-> Array<String> {
        var lists: [String]
        lists = Array()
        
        let listDir = FileUtilities.verbListDirectoryPath()
        do {
            lists = try FileManager.default.contentsOfDirectory(atPath: listDir)
        } catch let error as NSError {
            Log.errorMsg("error getting verblists \(error.description)")
        }
        
        return lists
    }
    
//
    class func copySettingsDatabaseToDocuments() -> Bool {
        var error: NSError?
        var retVal: Bool = true
//        var db = databaseName
        let destURL = documentsDirectoryURL().appendingPathComponent(LanguageGlobals.settingsDatabaseName)
        let sourceURL = resourceDirectoryURL().appendingPathComponent(LanguageGlobals.settingsDatabaseName)
        

        if FileManager.default.fileExists(atPath: destURL.path) == false {
            do {
                try FileManager.default.copyItem(at: sourceURL, to: destURL)
            } catch let error1 as NSError {
                error = error1
            }
            if let actualError = error {
                Log.print("Error copying \(LanguageGlobals.settingsDatabaseName) from \(sourceURL) to \(destURL): \(actualError)")
                retVal = false
            }
        }
        return retVal
        
    }
   

    
    class func addSkipBackupAttributeToItemAtURL(URL:Foundation.URL) -> Bool    {
        //TODO: add skip backup functionality
//        let fileManager = NSFileManager.defaultManager()
        let success: Bool = true
//        assert(fileManager.fileExistsAtPath(URL.path!))
        
//        var error:NSError?
//        let success:Bool = URL.setResourceValue(NSNumber.numberWithBool(true),forKey: NSURLIsExcludedFromBackupKey, error: &error)
//        let success: Bool = URL.setResourceValue(NSNumber.numberWithBool(true), forKey: NSURLIsExcludedFromBackupKey, error: &error)
        
//        if !success{
//            
//            println("Error excluding \(URL.lastPathComponent) from backup \(error)")
//        }
        
        return success;
    }

}
