//
//  UITxtFieldExt.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 7/16/17.
//  Copyright © 2017 verbtrainers. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.buttonBackground(scheme: sch!)
        self.setTitleColor(VtColor.buttonTextColor(scheme: sch!), for: .normal)
    }
    func formatTransparent(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.buttonTransparentBackground(scheme: sch!)
        self.setTitleColor(VtColor.buttonTextColor(scheme: sch!), for: .normal)
    }
    
    func settingButtonFormat(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.buttonBackground(scheme: sch!)
        self.setTitleColor(VtColor.buttonTextColor(scheme: sch!), for: .normal)
    }

}

extension UITextField {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.textFieldBackground(scheme: sch!)
        self.textColor = VtColor.textFieldTextColor(scheme: sch!)
    }
    
    
}

extension UITextView {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.textFieldBackground(scheme: sch!)
        self.textColor = VtColor.textFieldTextColor(scheme: sch!)
    }
}
//
extension UILabel {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.labelBackground(scheme: sch!)
        self.textColor = VtColor.labelTextColor(scheme: sch!)
    }
    func formatLight(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.labelBackground(scheme: sch!)
        self.textColor = VtColor.labelDimTextColor(scheme: sch!)
    }
}

extension UITabBar {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.labelBackground(scheme: sch!)
        self.tintColor = VtColor.textFieldTextColor(scheme: sch!)
        self.barTintColor = VtColor.labelBackground(scheme: sch!)
        }
    }


extension UITableView {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.labelBackground(scheme: sch!)
    }
}

extension  UITableViewCell {
    override func format(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.labelBackground(scheme: sch!)
        self.textLabel?.textColor = VtColor.labelTextColor(scheme: sch!)
    }
    
    func setSelectedScheme(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.contentView.backgroundColor = VtColor.tableViewCell(scheme: sch!)
        self.textLabel?.textColor = VtColor.labelTextColor(scheme: sch!)
    }
    
    func setUnSelectedScheme(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        //        self.backgroundColor = VtColor.labelBackground(scheme: sch!)
        self.contentView.backgroundColor = VtColor.labelBackground(scheme: sch!)
        self.textLabel?.textColor = VtColor.labelTextColor(scheme: sch!)
//        switch scheme {
//        case 0:
//            self.contentView.backgroundColor = UIVtColor.white
//            self.textLabel?.textColor = UIVtColor.black
//        case 1:
//            self.contentView.backgroundColor = UIVtColor.black
//            self.textLabel?.textColor = UIVtColor.white
//        default:
//            self.contentView.backgroundColor = UIVtColor.white
//            self.textLabel?.textColor = UIVtColor.black
//            
//        }
        
    }

}

extension UIView {
    @objc func format(scheme: Int32){
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.viewBackground(scheme: sch!)
    }
    
    func format(scheme: Int32, border: Bool){
        let sch = ColorScheme(rawValue: Int32(scheme))
        
        self.backgroundColor = VtColor.viewBackground(scheme: sch!)
        
        self.layer.borderColor =  VtColor.textFieldTextColor(scheme: sch!).cgColor
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true;

    }
    func formatDim(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.labelDimTextColor(scheme: sch!)
        
    }

    func formatInPopover(scheme: Int32) {
        let sch = ColorScheme(rawValue: Int32(scheme))
        self.backgroundColor = VtColor.popoverBackground(scheme: sch!)
        
    }
    
}


import UIKit

extension UIColor {
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
