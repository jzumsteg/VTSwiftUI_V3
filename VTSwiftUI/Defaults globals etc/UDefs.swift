//
//  SwCloudUserDefaults-sans-cloud.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 1/23/15.
//  Copyright (c) 2015 verbtrainers. All rights reserved.
//

import Foundation

/*
 to convert to cloud, must change object and string to retrieve from Cloud drive or ubiquitousContainer
 also change set to write to cloud drive or ubiq container
 */


class UDefs {
    var updateUbiquityContainer: Bool = false
    
   
    //MARK: getters
   
    class func object(forKey: String) -> NSNumber? {
        if UDefs.defaultExists(forKey: forKey) == false {
            return nil
        }
        else {
//            let x = UserDefaults.standard.object(forKey: forKey) as? NSNumber
            return UserDefaults.standard.object(forKey: forKey) as? NSNumber
        }
    }

    class func string(forKey:String) -> String? {
        if UDefs.defaultExists(forKey: forKey) == false {
            return nil
        }
        else {
            return UserDefaults.standard.object(forKey: forKey) as? String
        }
    }
    
    class func string(forKey:String, withDefault: String) -> String {
        if UDefs.defaultExists(forKey: forKey) {
            return UDefs.string(forKey: forKey)!
        }
        else {
            UDefs.set(value: withDefault, forKey: forKey)
            return withDefault
        }
    }
    
    
    class func defaultExists(forKey: String) -> Bool {
        guard (UserDefaults.standard.object(forKey: forKey) != nil) else {
            return false
        }
        return true
    }
    
    class func int(forKey: String) -> Int? {
        if UDefs.defaultExists(forKey: forKey) == true {
            return UDefs.object(forKey: forKey)?.intValue
        }
        else {
            return nil
        }
    }
    class func int(forKey: String, withDefault: Int) -> Int {
        if UDefs.defaultExists(forKey: forKey) {
            return (UDefs.object(forKey: forKey)?.intValue)!
        }

        UDefs.set(value: withDefault, forKey: forKey)
        return withDefault
    }
    
    class func int32(forKey: String) -> Int32? {
        var retVal: Int32
        if UDefs.defaultExists(forKey: forKey) {
            retVal = (UDefs.object(forKey: forKey)?.int32Value)!
            return retVal
        }
        return nil
        
    }
    class func int32(forKey: String, withDefault: Int32) -> Int32 {
        var retVal: Int32
        if UDefs.defaultExists(forKey: forKey) {
            retVal = (UDefs.object(forKey: forKey)?.int32Value)!
            return retVal
        }
        UDefs.set(value: Int(withDefault), forKey: forKey)
        return withDefault
    }

    
    class func bool(forKey: String) -> Bool? {
        let x = UDefs.object(forKey: forKey)?.boolValue
        return x
    }
    
    class func bool(forKey: String, withDefault: Bool) -> Bool {
        if let retVal = UDefs.bool(forKey: forKey) {
            return retVal
        }
        UDefs.set(value: withDefault, forKey: forKey)
        return withDefault
        
    }
    
    class func float(forKey: String) -> Float? {
        return UDefs.object(forKey: forKey)?.floatValue
    }

    class func float(forKey: String, withDefault: Float) -> Float {
        if let retVal = UDefs.float(forKey: forKey) {
            return retVal
        }
        UDefs.set(value: withDefault, forKey: forKey)
        return withDefault
    }
    
    class func double(forKey: String) -> Double? {
        return UDefs.object(forKey: forKey)?.doubleValue
    }

    class func double(forKey: String, withDefault: Double) -> Double {
        if let retVal:Double = UDefs.double(forKey: forKey) {
            return retVal
        }
        UDefs.set(value: withDefault, forKey: forKey)
        return withDefault
        
    }
    
//    class func array(forKey: String) -> Array<AnyObject> {
//        return UDefs.object(forKey: forKey) as! Array<AnyObject>
//    }
//
    
    //MARK: setters
    
    class func set(value: NSNumber, forKey: String) {
        // value must be an NSNumber to use with Clouddrive. That's why these are done to use NSNumber
        UDefs.setObject(anObject: value, forKey: forKey)
    }

    class func set(value:String, forKey aKey:String) {
        UDefs.setObject(anObject: value as AnyObject, forKey: aKey)
    }
    
    class func set(value:Bool, forKey aKey: String) {
        let cloudVal = NSNumber(value: value as Bool)
        UDefs.setObject(anObject: cloudVal, forKey: aKey)
        
    }
    
    class func set(value: Int, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        UDefs.set(value: cloudVal, forKey: aKey)
    }
    
    class func set(value: Int32, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        UDefs.set(value: cloudVal, forKey: aKey)
    }
    
    class func set(value: Float, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        UDefs.setObject(anObject: cloudVal, forKey: aKey)
    }

    class func set(value: Double, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        UDefs.setObject(anObject: cloudVal, forKey: aKey)
    }

    class func setArray(value: Array<AnyObject>, forKey aKey: String) {
        UDefs.setObject(anObject: value as AnyObject, forKey: aKey)
        
    }
    
    // if this is used...change to cloud drive or ubiq container
    class func setObject(anObject: AnyObject, forKey aKey: String) {
        UserDefaults.standard.set(anObject, forKey:aKey)
        NSUbiquitousKeyValueStore.default.set(anObject, forKey: aKey)
    }

    // MARK: other
    
    class func printUserdefaults() {

        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            Log.print("\(key) = \(value) \n")
        }
    }
    class func removeObject(aKey: String) {
//        NSUbiquitousKtore.default().removeObject( aKey)
    }
     // change remove to remove from cloud drive or ubiq container
    class func removeDefault(aKey: String) {
        UserDefaults.standard.removeObject(forKey: aKey)
    }
    class func synchronize() {
    UserDefaults.standard.synchronize()
    }
    
    //To-do: for cloud drive or ubiq container, must add code to actuall register for notifications
    class func registerForNotifications() {
    }
//
//        NSNotificationCenter.defaultCenter().addObserverForName("NSUbiquitousKtoreDidChangeExternallyNotification", object: NSUbiquitousKtore.defaultStore(), queue: nil, usingBlock: { note in
//            var defaults = NSUserDefaults.standardUserDefaults()
//            var cloud = NSUbiquitousKtore.defaultStore()
//            var info = note.userInfo as NSDictionary
//            var changedKeys = info("NSUbiquitousKtoreChangedKeysKey")
//            for a in changedKeys {
//                defaults.setObject(cloud.objectForKey(a), forKey: a)
//            }
//        })
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"NSUbiquitousKtoreDidChangeExternallyNotification"
//    object:[NSUbiquitousKtore defaultStore]
//    queue:nil
//    usingBlock:^(NSNotification* notification) {
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    NSUbiquitousKtore* cloud = [NSUbiquitousKtore defaultStore];
//    NSDictionary* changedKeys = [notification.userInfo objectForKey:@"NSUbiquitousKtoreChangedKeysKey"];
//    for (NSString* a in changedKeys) {
//    [defaults setObject:[cloud objectForKey:a] forKey:a];
//    }
//    }];
    
//    }
    
//    class func removeNotifications() {
//        NSNotificationCenter.defaultCenter().removeObserver(NSUbiquitousKtore.defaultStore())
//    }


    

}
