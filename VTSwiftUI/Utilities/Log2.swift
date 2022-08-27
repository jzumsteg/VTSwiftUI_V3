//
//  Log2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 3/31/22.
//

import Foundation

import Foundation

class Log2 {
    static let shared: Log2 = Log2()
    var logFilePath: String = "/Volumes/User Drive/Development/ios/VTSwiftUI_V3/Log/log.txt"
    
    private init() {
        if (FileManager.default.createFile(atPath: logFilePath, contents: nil, attributes: nil)) {
            Swift.print("File created successfully.")
            
        } else {
            Swift.print("File not created.")
        }
    }

    func print (_ str:  String, logLevel: Int = 0) {
        let fileURL = URL(fileURLWithPath: logFilePath)
        #if DEBUG
            Swift.print("\(str)")
            let txtStr = "\(str)\r\n"
        if let handle = try? FileHandle(forWritingTo: fileURL) {
            handle.seekToEndOfFile() // moving pointer to the end
            handle.write(txtStr.data(using: .utf8)!) // adding content
            handle.closeFile() // closing the file
        }
        #endif
    }
    func print (_ str:  Any, logLevel: Int = 0) {
        #if DEBUG
            Swift.print("\(str)")

        #endif
    }
    
    func printMany(_ msgStr: String, params: Any...) {
        // replace the
    }
    
    func printMethod(_ cls: String, method: String) {
        #if DEBUG
            let clsStr =  cls.replacingOccurrences(of: "Verbtrainer-Swift", with: "")
        Swift.print("\(clsStr) : \(method)")
        #endif
        
    }
    
    func methodEnter(
        _ function: String = #function,
        file: String = #file,
        line: Int = #line) {
        #if DEBUG
            Swift.print("Entering  \(file.lastPathComponent.stringByDeletingPathExtension): \(function): \(line))")
        #endif
    }
    
    func errorMsg(_ msg: String,
        function: String = #function,
        file: String = #file,
        line: Int = #line) {
        #if DEBUG
            Swift.print("\(msg) occurred at: \(file.lastPathComponent.stringByDeletingPathExtension): \(function): \(line))")
        #endif
    }
    

}
