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


class JzUserDefaults {
    var updateUbiquityContainer: Bool = false
    
   
    //MARK: getters
   
    class func object(forKey: String) -> NSNumber? {
        if JzUserDefaults.defaultExists(forKey: forKey) == false {
            return nil
        }
        else {
//            let x = UserDefaults.standard.object(forKey: forKey) as? NSNumber
            return UserDefaults.standard.object(forKey: forKey) as? NSNumber
        }
    }

    class func string(forKey:String) -> String? {
        if JzUserDefaults.defaultExists(forKey: forKey) == false {
            return nil
        }
        else {
            return UserDefaults.standard.object(forKey: forKey) as? String
        }
    }
    
    class func string(forKey:String, withDefault: String) -> String {
        if JzUserDefaults.defaultExists(forKey: forKey) {
            return JzUserDefaults.string(forKey: forKey)!
        }
        else {
            JzUserDefaults.set(value: withDefault, forKey: forKey)
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
        if JzUserDefaults.defaultExists(forKey: forKey) == true {
            return JzUserDefaults.object(forKey: forKey)?.intValue
        }
        else {
            return nil
        }
    }
    class func int(forKey: String, withDefault: Int) -> Int {
        if JzUserDefaults.defaultExists(forKey: forKey) {
            return (JzUserDefaults.object(forKey: forKey)?.intValue)!
        }

        JzUserDefaults.set(value: withDefault, forKey: forKey)
        return withDefault
    }
    
    class func int32(forKey: String) -> Int32? {
        var retVal: Int32
        if JzUserDefaults.defaultExists(forKey: forKey) {
            retVal = (JzUserDefaults.object(forKey: forKey)?.int32Value)!
            return retVal
        }
        return nil
        
    }
    class func int32(forKey: String, withDefault: Int32) -> Int32 {
        if let retVal = JzUserDefaults.int32(forKey: forKey)
        {
            return retVal
        }
        JzUserDefaults.set(value: withDefault, forKey: forKey)
        return withDefault
    }

    
    class func bool(forKey: String) -> Bool? {
        let x = JzUserDefaults.object(forKey: forKey)?.boolValue
        print("returning \(x) for key \(forKey)")
        return x
    }
    
    class func bool(forKey: String, withDefault: Bool) -> Bool {
        if let retVal = JzUserDefaults.bool(forKey: forKey) {
            return retVal
        }
        JzUserDefaults.set(value: withDefault, forKey: forKey)
        return withDefault
        
    }
    
    class func float(forKey: String) -> Float? {
        return JzUserDefaults.object(forKey: forKey)?.floatValue
    }

    class func float(forKey: String, withDefault: Float) -> Float {
        if let retVal = JzUserDefaults.float(forKey: forKey) {
            return retVal
        }
        JzUserDefaults.set(value: withDefault, forKey: forKey)
        return withDefault
    }
    
    class func double(forKey: String) -> Double? {
        return JzUserDefaults.object(forKey: forKey)?.doubleValue
    }

    class func double(forKey: String, withDefault: Double) -> Double {
        if let retVal:Double = JzUserDefaults.double(forKey: forKey) {
            return retVal
        }
        JzUserDefaults.set(value: withDefault, forKey: forKey)
        return withDefault
        
    }
    
//    class func array(forKey: String) -> Array<AnyObject> {
//        return JzUserDefaults.object(forKey: forKey) as! Array<AnyObject>
//    }
//
    
    //MARK: setters
    
    class func set(value: NSNumber, forKey: String) {
        // value must be an NSNumber to use with Clouddrive. That's why these are done to use NSNumber
        JzUserDefaults.setObject(anObject: value, forKey: forKey)        
    }

    class func set(value:String, forKey aKey:String) {
        JzUserDefaults.setObject(anObject: value as AnyObject, forKey: aKey)
    }
    
    class func set(value:Bool, forKey aKey: String) {
        let cloudVal = NSNumber(value: value as Bool)
        JzUserDefaults.setObject(anObject: cloudVal, forKey: aKey)
        
    }
    
    class func set(value: Int, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        JzUserDefaults.set(value: cloudVal, forKey: aKey)
    }
    
    class func set(value: Int32, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        if aKey == KeyValues.keyColorScheme {
            Log.print("cloudVal: \(cloudVal)")
        }
        JzUserDefaults.setObject(anObject: cloudVal, forKey: aKey)
    }
    
    class func set(value: Float, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        JzUserDefaults.setObject(anObject: cloudVal, forKey: aKey)
    }

    class func set(value: Double, forKey aKey: String) {
        let cloudVal = NSNumber(value: value)
        JzUserDefaults.setObject(anObject: cloudVal, forKey: aKey)
    }

    class func setArray(value: Array<AnyObject>, forKey aKey: String) {
        JzUserDefaults.setObject(anObject: value as AnyObject, forKey: aKey)
        
    }
    
    // if this is used...change to cloud drive or ubiq container
    class func setObject(anObject: AnyObject, forKey aKey: String) {
//        print("Setting :\(aKey) to \(anObject)")
        UserDefaults.standard.set(anObject, forKey:aKey)
        NSUbiquitousKeyValueStore.default.set(anObject, forKey: aKey)
    }

    // MARK: other
    class func removeObject(aKey: String) {
//        NSUbiquitousKeyValueStore.default().removeObject( aKey)
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
//        NSNotificationCenter.defaultCenter().addObserverForName("NSUbiquitousKeyValueStoreDidChangeExternallyNotification", object: NSUbiquitousKeyValueStore.defaultStore(), queue: nil, usingBlock: { note in
//            var defaults = NSUserDefaults.standardUserDefaults()
//            var cloud = NSUbiquitousKeyValueStore.defaultStore()
//            var info = note.userInfo as NSDictionary
//            var changedKeys = info("NSUbiquitousKeyValueStoreChangedKeysKey")
//            for a in changedKeys {
//                defaults.setObject(cloud.objectForKey(a), forKey: a)
//            }
//        })
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"NSUbiquitousKeyValueStoreDidChangeExternallyNotification"
//    object:[NSUbiquitousKeyValueStore defaultStore]
//    queue:nil
//    usingBlock:^(NSNotification* notification) {
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    NSUbiquitousKeyValueStore* cloud = [NSUbiquitousKeyValueStore defaultStore];
//    NSDictionary* changedKeys = [notification.userInfo objectForKey:@"NSUbiquitousKeyValueStoreChangedKeysKey"];
//    for (NSString* a in changedKeys) {
//    [defaults setObject:[cloud objectForKey:a] forKey:a];
//    }
//    }];
    
//    }
    
//    class func removeNotifications() {
//        NSNotificationCenter.defaultCenter().removeObserver(NSUbiquitousKeyValueStore.defaultStore())
//    }


    

}
