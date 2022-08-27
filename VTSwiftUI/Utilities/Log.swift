//
//  Log.swift
//  MyWalks-Swift
//
//  Created by John Zumsteg on 4/30/15.
//  Copyright (c) 2015 iBallApps. All rights reserved.
//

//let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
//
//do {
//    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
//} catch {
//    // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//}

import Foundation

class Log {
    class func print (_ str:  String, logLevel: Int = 0) {
        #if DEBUG
            Swift.print("\(str)")
        #endif
    }
    class func print (_ str:  Any, logLevel: Int = 0) {
        #if DEBUG
            Swift.print("\(str)")

        #endif
    }
    
    class func printMany(_ msgStr: String, params: Any...) {
        // replace the
    }
    
    class func printMethod(_ cls: String, method: String) {
        #if DEBUG
            let clsStr =  cls.replacingOccurrences(of: "Verbtrainer-Swift", with: "")
            print("\(clsStr) : \(method)")
        #endif
        
    }
    
    class func methodEnter(
        _ function: String = #function,
        file: String = #file,
        line: Int = #line) {
        #if DEBUG
        print("Entering  \(file.lastPathComponent.stringByDeletingPathExtension): \(function): \(line))")
        #endif
    }
    
    class func errorMsg(_ msg: String,
        function: String = #function,
        file: String = #file,
        line: Int = #line) {
        #if DEBUG
            Swift.print("\(msg) occurred at: \(file.lastPathComponent.stringByDeletingPathExtension): \(function): \(line))")
        #endif
    }
    

}
