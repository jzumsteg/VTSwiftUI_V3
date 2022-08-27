//
//  HistoryViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/18/22.
//

import Foundation
class HistoryViewModel: ObservableObject {
//    @Published var historyList = [(String, String, String, String, String)]()
    @Published var historyList = [String]()
    @Published var cellCount: Int = 0

    init() {
//        historyList = [String]()
    }
    
    func setup() {
        getHistoryList()
    }
    
    func getHistoryList() {
        
        // add the headings
        historyList.removeAll()
        historyList.append("Date/Time")
        historyList.append("Num Tests")
        historyList.append("Pct Right")
        
        let db = DB.shared.historyDB
        let sql = "SELECT * FROM quizHistories ORDER BY datetime DESC;"
        guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {return}
        while (rs.next()) {
            let dt = rs.string(forColumn: "dateTime") ?? "No date time"
            let numTests = rs.int(forColumn: "numTests")
            let numRight = rs.int(forColumn: "numRight")
//            let numWrong = numTests - numRight
            
            var pct = ""
            if numTests > 0 && numRight == 0 {
                pct = "0.0"
            }
            if numTests == 0 {
                pct = "-"
            }
            else {
                let formattedValue = String(format: "%.1f", (Float(numRight) / Float(numTests) * 100.0))
                pct = formattedValue + "%"
            }
            
            let dtStr = parseDateTime(dt: dt)

            historyList.append(dtStr)
            historyList.append("\(numTests)")
//            historyList.append("\(numRight)")
            historyList.append(pct)
            

        }
        cellCount = historyList.count
    }
    
    func parseDateTime(dt: String) -> String {
        var retStr = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd h:mm:ss"
        if let date = dateFormatter.date(from: dt) {
            print(date)
            
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("yy-MM-dd H:mm")
             retStr = formatter.string(from: date)
        }
        return retStr
    }
    
    func clearHistory() {
        Log.methodEnter()
        historyList = [String]()
        let db = DB.shared.historyDB
//        let sql = "DELETE FROM quizHistories;"
        db.executeUpdate("DELETE FROM quizHistories;", withArgumentsIn: [])
        getHistoryList()
    }
    

}
