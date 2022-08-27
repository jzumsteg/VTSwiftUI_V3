//
//  SettingState.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 9/15/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//
//enum settingType {
//    case simple
//    case compound
//    case verbType
//    case ending
//    case person
//}

import Foundation
class SettingState {
    var name: String
    var type: SettingsType
    var state: Bool
    var whereStr: String?
    init() {
        name = String()
        type = .simple
        self.state = false
    }
    
    convenience init(name: String, type: SettingsType, state: Bool) {
        self.init()
        self.state = state
    }
}
