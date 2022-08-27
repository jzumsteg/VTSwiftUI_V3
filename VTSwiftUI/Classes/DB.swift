//
//  DB.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 7/16/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//

import Foundation
import FMDB
class DB {
    var verbDb: FMDatabase
    var stateDb: FMDatabase
    var historyDB: FMDatabase
    static let shared: DB = DB()
    
    private init() {
        // FIX-ME: need to manage the situation where there is no database in Documents or they won't open
        let verbDbPath = FileUtilities.verbDatabasePath()
        verbDb = FMDatabase(path: verbDbPath)
        verbDb.open()
        
        
        let stateDBPath = FileUtilities.settingsDatabasePath()
        if FileManager.default.fileExists(atPath: stateDBPath) == false {
            _ = FileUtilities.copySettingsDatabaseToDocuments()
        }
        stateDb = FMDatabase(path: stateDBPath)
        stateDb.open()
        
        let historyDBPath = FileUtilities.settingsDatabasePath()
        if FileManager.default.fileExists(atPath: historyDBPath) == false {
            _ = FileUtilities.copySettingsDatabaseToDocuments()
        }
        historyDB = FMDatabase(path: historyDBPath)
        historyDB.open()
        
        // create the history table if it does not exist
        var sql = "CREATE TABLE IF NOT EXISTS quizHistories (dateTime TEXT,numTests INTEGER, numRight INTEGER);"
        do {
            try historyDB.executeUpdate(sql, values: [])
        } catch {
            Log.print("error: \(historyDB.lastError())")
        }
        
        sql = "CREATE UNIQUE INDEX IF NOT  EXISTS \"dateTime\" ON \"quizHistories\" (\"dateTime\");"
        do {
            try historyDB.executeUpdate(sql, values: [])
        } catch {
            Log.print("error")
        }
    }
    
    func closeAndReopen() {
        verbDb.close()
        let verbDbPath = FileUtilities.verbDatabasePath()
        verbDb = FMDatabase(path: verbDbPath)
        verbDb.open()
        
        stateDb.close()
        let stateDBPath = FileUtilities.settingsDatabasePath()
        stateDb = FMDatabase(path: stateDBPath)
        stateDb.open()

    }
    
    func closeState() {
        stateDb.close()
    }
    
    func closeVerbs() {
        verbDb.close()
    }
    func closeHistoryDB() {
        historyDB.close()
    }
}

