//
//  String_ext.swift
//  AnyMaps
//
//  Created by jzumsteg on 6/25/15.
//  Copyright (c) 2015 jzumsteg. All rights reserved.
//

import Foundation
extension String {
   var fileExists: Bool {
      return FileManager().fileExists(atPath: self)
   }


    func rightPaddedToWidth(_ width: Int) -> String {
        let length = self.count
        guard length < width else {
            return self
        }

        let spaces = Array<Character>.init(repeating: " ", count: width - length)
        return spaces + self
    }
    
    func leftPaddedToWidth(_ width: Int) -> String {
        let length = self.count
        guard length < width else {
            return self
        }

        let spaces = Array<Character>.init(repeating: " ", count: width - length)
        return spaces + self
    }
    
    func centerPaddedToWidth(_ width: Int) -> String {
        let length = self.count
        let rightPad = ((width - length) / 2)
        let leftPad = width - length - rightPad
        guard length < width else {
            return self
        }

        let rightSpaces = Array<Character>.init(repeating: ".", count: rightPad)
        let leftSpaces = Array<Character>.init(repeating: ".", count: leftPad)
        return leftSpaces + self + rightSpaces
    }

    
    func paddingLeft(with character: Character, maxLength: Int) -> String {
        return maxLength - self.count > 0 ? String(repeating: String(character), count: maxLength - self.count) + self : self
    }

    func removePrefix(numChars: Int) -> String {
        return String(self.dropFirst(numChars))

    }
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])

    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        let range = startIndex..<endIndex // If you have a range
        return String(self[range])  // Swift 4
    }

    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    public var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).deletingLastPathComponent
        }
    }
    public var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).deletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    public func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathComponent(path)
    }
    
    public func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathExtension(ext)
    }
//    func toDouble() -> Double? {
//        let formatter = NSNumberFormatter()
//        formatter.locale = NSLocale(localeIdentifier: "fr_FR")
//        if let decimalAsDoubleUnwrapped = formatter.numberFromString(self) {
//            return decimalAsDoubleUnwrapped.doubleValue
//        
//        }
//        else {
//            return nil
//        }
//    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }

    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var int32Value: Int32 {
        return Int32((self as NSString).intValue)
    }

}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
