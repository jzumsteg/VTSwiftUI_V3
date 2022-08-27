//
//  SettingsViewBurronModifier.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/20/22.
//

import Foundation
import SwiftUI

struct SettingsViewStype: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(Color("ButtonText"))
            Spacer()
        } // HStack:13
        .padding(.top, 5)
        .padding(.bottom, 5)
        .background(Color("ButtonBackground"))
        .foregroundColor(Color("ButtonText"))
        .cornerRadius(8)
        .scaleEffect(configuration.isPressed ? 0.90 : 1)
    }
}

