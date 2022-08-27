//
//  File.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 7/15/17.
//  Copyright © 2017 verbtrainers. All rights reserved.
//

import Foundation
import UIKit

/**
 color scheme for light text on dark backgroud: Muto at http://www.color-hex.com/color-palette/42091
 */

class VtColor {
    class func viewBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor.secondarySystemBackground
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = UIColor(named:"ViewBackground")!
            case .light_on_dark:
                retColor = UIColor(named:"ViewForeground")!
            }
        }
        return retColor
    }
    
    class func popoverBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor.secondarySystemBackground
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 80.0, green: 80.0, blue: 80.0)  // white
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 188.0, green: 210.0, blue: 208.0)
            }
        }
        return retColor
    
    }
    class func popoverDarkBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        switch scheme {
        case .dark_on_light:
            retColor = Utilities.makeUIColor(red: 80.0, green: 80.0, blue: 80.0)  // wdark gray
        case .light_on_dark:
            retColor = Utilities.makeUIColor(red: 188.0, green: 210.0, blue: 208.0)
        }
        return retColor
        
    }


    class func textFieldBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "TextFieldBackground")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 235.0, green: 235.0, blue: 235.0)  // white
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 79.0, green: 91.0, blue: 102.0, alpha: 0.2)
    //            retColor = Utilities.makeUIColor(red: 41.0, green: 45.0, blue:49.0)
            }
        }
        return retColor
    }
    
    class func textFieldTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "AllText")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 0.0, green: 0.0, blue: 0.0)  // black
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
            }
//            Log.print("\(retColor)")
        }
        return retColor
    }

    class func webPageBackgroundColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor.secondarySystemBackground
//            print("hex of retColor: \(retColor.toHex()!)")
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 36.0, green: 42.0, blue: 49.0)
            }
        }
//        print("hex of retColor: \(retColor.toHex()!)")
        return retColor
    }
    
    class func tableBackgroundColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor.secondarySystemBackground
//            print("hex of retColor: \(retColor.toHex()!)")
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 36.0, green: 42.0, blue: 49.0)
            }
        }
        print("hex of retColor: \(retColor.toHex()!)")
        return retColor
    }
    
    class func tableTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "AllText")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 0.0, green: 0.0, blue: 0.0)  // black
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
            }
        }
        return retColor
    }

    

    class func textFieldDimTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "AllText")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 50.0, green: 50.0, blue: 50.0)  // dark gray
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 200.0, green: 200.0, blue: 200.0)
            }
        }
        return retColor
    }

    class func buttonTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "ButtonText")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 0.0, green: 122.0, blue: 255.0, alpha: 1.0)
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 125.0, green: 234.0, blue: 255.0, alpha: 1.0)
            }
        }
        return retColor
    }
    
    class func settingsButtonTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        switch scheme {
        case .dark_on_light:
            retColor = Utilities.makeUIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .light_on_dark:
            retColor = Utilities.makeUIColor(red: 0.0, green: 0.0, blue: 255.0, alpha: 1.0)
        }
        return retColor
    }

    class func settingsButtonBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        switch scheme {
        case .light_on_dark:
            retColor = Utilities.makeUIColor(red: 204.0, green: 232, blue: 255.0)
        case .dark_on_light:
            retColor = Utilities.makeUIColor(red:152.0, green: 203.0, blue: 251.0)
        }
        return retColor
    }
    
    
    class func buttonBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "ButtonBackground")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 200.0, green: 200.0, blue: 200.0)  // white
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 79.0, green: 91.0, blue: 102.0)
            }
        }
        return retColor
    }
    
    class func buttonTransparentBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        switch scheme {
        case .dark_on_light:
            retColor = Utilities.makeUIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.0)  // white
        case .light_on_dark:
            retColor = Utilities.makeUIColor(red: 79.0, green: 91.0, blue: 102.0, alpha: 0.0)
        }
        return retColor
    }


    class func labelBackground(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor.secondarySystemBackground
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 36.0, green: 42.0, blue: 49.0)
            }
            retColor = VtColor.viewBackground(scheme: scheme)
        }
        return retColor
    }
    
    class func labelTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "AllText")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 36.0, green: 42.0, blue: 49.0)
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
            }
        }
        return retColor
    }
    
    class func labelDimTextColor(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        if #available(iOS 13, *) {
            retColor = UIColor(named: "AllText")!
        }
        else {
            switch scheme {
            case .dark_on_light:
                retColor = Utilities.makeUIColor(red: 50.0, green: 50.0, blue: 50.0, alpha: 0.75)  // dark gray
            case .light_on_dark:
                retColor = Utilities.makeUIColor(red: 200.0, green: 200.0, blue: 200.0, alpha: 0.75)
            }
        }
        return retColor
    }
    
    class func tableViewCell(scheme: ColorScheme) -> UIColor {
        var retColor: UIColor
        switch scheme {
        case .dark_on_light:
            retColor = Utilities.makeUIColor(red: 240.0, green: 240.0, blue: 240.0)  // dark gray
        case .light_on_dark:
            retColor = Utilities.makeUIColor(red: 79.0, green: 91.0, blue: 102.0)
        }
        return retColor
        
    }

    
    class func colorTextField(fld: UITextField, scheme: ColorScheme) -> UITextField {
        switch scheme {
        case .dark_on_light:
            fld.backgroundColor = Utilities.makeUIColor(red: 245.0, green: 245.0, blue: 245.0)  // white
        case .light_on_dark:
            fld.backgroundColor = Utilities.makeUIColor(red: 36.0, green: 42.0, blue: 49.0)
        }
        return fld
    }
    

    
    class func borderView(v: UIView, scheme: ColorScheme) {
        switch scheme {
        case .dark_on_light:
            v.layer.borderColor =  UIColor.lightGray.cgColor
        case .light_on_dark:
//            let frameColor = Utilities.makeUIColor(red: 36.0, green: 42.0, blue: 49.0)
            v.layer.borderColor = UIColor.lightGray.cgColor
        }

        v.layer.borderWidth = 1.0;
        v.layer.cornerRadius = 5;
        v.layer.masksToBounds = true;
        
    }
    
    class func cssHTML(scheme: ColorScheme) -> String {
        var cssStr = String()
        var textColorHex = String()
        let device = UIDevice.current.userInterfaceIdiom
        
        var h1Font: String
        var h2Font: String
        var h3Font: String
        var stdFont: String
        var stdBoldFont: String
        var hdrFont: String

        switch device {
        case .unspecified:
            h1Font = "42"
            h2Font = "40"
            h3Font = "38"
            stdFont = "36"
            stdBoldFont = "36"
            hdrFont = "36"
        case .phone:
            h1Font = "42"
            h2Font = "40"
            h3Font = "38"
            stdFont = "36"
            stdBoldFont = "36"
            hdrFont = "36"
        case .pad:
            h1Font = "30"
            h2Font = "28"
            h3Font = "24"
            stdFont = "18"
            stdBoldFont = "18"
            hdrFont = "24"
        case .tv:
            h1Font = "42"
            h2Font = "40"
            h3Font = "38"
            stdFont = "36"
            stdBoldFont = "36"
            hdrFont = "36"
        case .carPlay:
            h1Font = "42"
            h2Font = "40"
            h3Font = "38"
            stdFont = "36"
            stdBoldFont = "36"
            hdrFont = "36"
        case .mac:
            h1Font = "42"
            h2Font = "40"
            h3Font = "38"
            stdFont = "36"
            stdBoldFont = "36"
            hdrFont = "36"
        @unknown default:
            fatalError()
        }

        textColorHex = UIColor(named: "AllText")!.toHex!

        let bckgrnd = UIColor(named: "BaseViewBackground")!
        let bckgrndHex = bckgrnd.toHex()!
        
        cssStr = "<HTML><TITLE>Verb Conjugation</TITLE><style type=\"text/css\">"
        cssStr += "h1 {color: #\(textColorHex);font-family: arial;font-size: \(h1Font)pt; font-weight: bold;}"
        cssStr += "h2 {color: #\(textColorHex);font-family: arial;font-size: \(h2Font)pt; font-weight: bold;}"
        cssStr += "h3 {color: #\(textColorHex);font-family: arial;font-size: \(h3Font)pt; font-weight: bold;}"
        cssStr += "std {color: #\(textColorHex);font-family: arial;font-size: \(stdFont)pt;}"
        cssStr += "stdbld  {color: #\(textColorHex);font-family: arial;font-size: \(stdBoldFont)pt; font-weight: bold;}"
        cssStr += "hdr {color: black;font-family: arial;font-size: \(hdrFont)pt; font-weight: bold; background-color: lightsteelblue}"
        cssStr += "</style>"
        cssStr += "<body bgcolor= #\(bckgrndHex)>"
        
        return cssStr

    }

}
