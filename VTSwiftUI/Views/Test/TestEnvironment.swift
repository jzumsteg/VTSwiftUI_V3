//
//  TestEnvironment.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/16/22.
//

import Foundation
class TestEnvironment: ObservableObject {
    @Published var showAnswerSwitch: Bool = false {
        didSet {
            Log.print("showAnswerSwitch: \(showAnswerSwitch)")
        }
    }
    @Published var testDone: Bool = true {
        didSet {
            Log.print("testDone: \(testDone)")
        }
    }
    @Published var showAlert: Bool = false
}
