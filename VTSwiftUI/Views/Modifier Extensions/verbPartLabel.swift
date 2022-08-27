//
//  verbPartLabel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/5/22.
//

import Foundation
import SwiftUI

extension View {
    func verbDescLabelStyle() -> some View {
        modifier(DescriptionLabel())
    }
    
    func verbPartLabelStyle() -> some View {
        modifier(VerbLabel())
    }

    func verbLabel2LinesStyle() -> some View {
        modifier(VerbLabelTwoLines())
    }
    func verbTranslationStyle() -> some View {
        modifier(VerbTranslationStyle())
    }
    func testSettingsInputStyle() -> some View {
        modifier(TestSettingsInput())
    }
    
}

struct TestSettingsInput: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .foregroundColor(Color("LabelText"))
        .border(Color("LabelText"))

    }
}

struct DescriptionLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .regular, design: .default).italic())
            .foregroundColor(.gray)
            .padding(.top, -5)
//            .border(Color.gray)
    }
}
struct VerbTranslationStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .regular, design: .default).italic())
            .foregroundColor(Color("LabelText"))
            .padding(.top, -5)
//            .border(Color.gray)
    }
}

struct VerbLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .foregroundColor(.blue)
            .padding(.top, -25)
    }
}

struct VerbLabelTwoLines: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .foregroundColor(.blue)
            .padding(.top, -15)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
