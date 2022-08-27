//
//  HTMLViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/25/22.
//

import Foundation
import UIKit

class HTMLViewModel: ObservableObject {
    
    func getHTMLString(whichView: web_views) -> String {
        var htmlString = ""
        var fname = FileUtilities.resourceDirectory().stringByAppendingPathComponent(path: "help.html")

        var colorScheme = ColorScheme()
        colorScheme.retrieve()

        
        let cssStr = VtColor.cssHTML(scheme: colorScheme)
        switch whichView {
        case .sample_conjugation:
            fname = FileUtilities.resourceDirectory().stringByAppendingPathComponent(path: "sampleConjugation.html")
        case .help_view:
            fname = FileUtilities.resourceDirectory().stringByAppendingPathComponent(path: "help.html")
            break
        case .info_view:
            fname = FileUtilities.resourceDirectory().stringByAppendingPathComponent(path: "info.html")
            break
        case .changes_view:
            fname = FileUtilities.resourceDirectory().stringByAppendingPathComponent(path: "changes.html")
        } // switch
        Log.print("fname: \(fname)")
        do {
                try htmlString = String(contentsOfFile: fname)
            } catch let error as NSError {
                Log.print(error.description)
                htmlString = "\(fname) not found)"
            }
        
        // get the app version number
        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
        // and sub it into the html string
        htmlString = cssStr + htmlString.replace(target: "XXVERSIONXX", withString: version)
        htmlString = htmlString.replace(target: "XXAPPXX", withString: LanguageGlobals.appTitle)
        
        // check the device. Set the columns to 50%-50% if this is running on an iPad. Otherwise, set them tp 25%-75%
        
//        let device = UIDevice.current.userInterfaceIdiom
//        switch device {
//        case .pad:
//            htmlString = htmlString.replace(target: "##LEFT-COL-PCT##", withString: "50%").replace(target: "##RIGHT-COL-PCT",withString: "50%")
//        case .phone:
//            htmlString = htmlString.replace(target: "##LEFT-COL-PCT##", withString: "35%").replace(target: "##RIGHT-COL-PCT",withString: "65%")
//
//        default:
//            htmlString = htmlString.replace(target: "##LEFT-COL-PCT##", withString: "25%").replace(target: "##RIGHT-COL-PCT",withString: "75%")
//
//        }

        
        htmlString = htmlString.replace(target: "##LEFT-COL-PCT##", withString: "35%").replace(target: "##RIGHT-COL-PCT",withString: "65%")

        htmlString = htmlString.replace(target: "320", withString: " = \(Int(UIScreen.main.bounds.width * 0.80))")

        
        return htmlString
        }
    


}


