//
//  View Modifiers.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 3/9/22.
//
import Foundation
import SwiftUI

struct EmptyDataModifier<Placeholder: View>: ViewModifier {
    
    let items: [Any]
    let placeholder: Placeholder
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if !items.isEmpty {
            content
        } else {
            placeholder
        }
    }
    
    
}
//// modifier to add a clear btton to a textField
//struct TextFieldClearButton: ViewModifier {
//    @Binding var text: String
//    
//    func body(content: Content) -> some View {
//        HStack {
//            content
//            
//            if !text.isEmpty {
//                Button(
//                    action: { self.text = "" },
//                    label: {
//                        Image(systemName: "delete.left")
//                            .foregroundColor(Color(UIColor.opaqueSeparator))
//                    }
//                )
//            }
//        }
//    }
//}

