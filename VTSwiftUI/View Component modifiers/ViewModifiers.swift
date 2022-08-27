//
//  ViewModifiers.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/23/22.
//

import Foundation
import SwiftUI

// full frame view
struct FullFrameViewSize: ViewModifier {
//    let action: (UIDeviceOrientation) -> Void
    @StateObject var orientation = Orientation()
    @State var initialOrientationIsLandScape = false
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    func body (content: Content) -> some View {
        content
            .onReceive(orientationChanged, perform: { _ in
                if initialOrientationIsLandScape {
                    initialOrientationIsLandScape = false
                } else {
                    orientation.isLandscape = UIDevice.current.orientation.isLandscape
                }
            })
            .onAppear {
                orientation.isLandscape = UIDevice.current.orientation.isLandscape
                initialOrientationIsLandScape = orientation.isLandscape
            }
            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 700 : UIScreen.main.bounds.width * 0.90)
            .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? min(700, UIScreen.main.bounds.height * 0.9) : UIScreen.main.bounds.height * 0.85)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("ButtonBorder"), lineWidth: 1)
            )

    }
}

extension View {
    func fullSizeFrameModifier() -> some View {
        modifier(FullFrameViewSize())
    }
}

// View Title
struct ViewTitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Open Sans", size: 24))
            .foregroundColor(Color("ButtonText"))

    }
}

struct ViewSmallTitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Open Sans", size: 20))
            .foregroundColor(Color("ButtonText"))

    }
}
extension View {
    func viewTitleStyle() -> some View {
        modifier(ViewTitleModifier())
    }
    
    func viewSmallTitleStyle() -> some View {
        modifier(ViewSmallTitleModifier())
    }
}


// List Row
struct ListRowModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Open Sans", size: 14))

    }
}
extension View {
    func listRowStyle() -> some View {
        modifier(ListRowModifier())
    }
}

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

// modifier to add a clear btton to a textField
struct TextFieldClearButton: ViewModifier {
    
        @Binding var text: String

        public func body(content: Content) -> some View
        {
            ZStack(alignment: .trailing)
            {
                content

                if !text.isEmpty
                {
                    Button(action:
                    {
                        self.text = ""
                    })
                    {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }


struct TestSettingsInput: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .foregroundColor(Color("LabelText"))
        .frame(width: 50, height: 40)
        .multilineTextAlignment(.center)
         .overlay(
             RoundedRectangle(cornerRadius: 4)
                 .stroke(Color("LabelText"), lineWidth: 1)
         )
         .padding()

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
            .foregroundColor(Color("ButtonText"))
            .padding(.top, -25)
    }
}

struct VerbLabelTwoLines: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .foregroundColor(Color("ButtonText"))
            .padding(.top, -15)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}



