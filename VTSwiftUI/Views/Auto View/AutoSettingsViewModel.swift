//
//  AutoSettingsViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/9/22.
//

import Foundation
import SwiftUI
class AutoSettingsViewModel: ObservableObject {
    @Published var drillInterval: Double?
    @Published var answerInterval: Double?
    
    @EnvironmentObject var model:AutoViewModel
    
    func setup () {
        
    }
}
