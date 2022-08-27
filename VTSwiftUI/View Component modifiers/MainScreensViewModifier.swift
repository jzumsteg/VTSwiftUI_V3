//
//  MainScreensViewModifier.swift
//  SheetTest
//
//  Created by John Zumsteg on 4/24/22.
//

import Foundation
import SwiftUI

struct MainScreenViewModifier: ViewModifier {
//    @ObservedObject var environmentals = EnvironmentalObjects()
//    @State private var orientation = UIDeviceOrientation.unknown
//
//    var horizontalInset = UIDevice.current.userInterfaceIdiom == .pad ? 200.0 : 5.0
//    var verticalInset = UIDevice.current.userInterfaceIdiom == .pad ? 200.0 : 5.0
//    var verticalScalePct: Double
//    var horizontalScalePct: Double
//    var desiredSize: CGSize
//    var horizontalSpacer: Double
//    var verticalSpacer: Double
//
    init() {

        let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        print("screen size width: \(screenSize.width), height: \(screenSize.height)")
    }
    func body(content: Content) -> some View {
        ZStack (alignment: .top){
        HStack {
            VStack {
                Text("Top Line")
                    .background(Color.clear)
//                    .border(Color.green)
                Spacer()
                content
                    .onAppear()
                Spacer()
                Text("Bottom line")
                    .background(Color.clear)
//                    .border(Color.green)
                
            } // vstack

            .frameInfo(color: Color.blue, "HStack")
            .padding(15)   // thsi padding sets the space between the content view and the hStack container
        }
        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 600 : UIScreen.main.bounds.width * 0.95)
        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? min(UIScreen.main.bounds.height * 0.95, 800) : UIScreen.main.bounds.height * 0.95)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(UIDevice.current.userInterfaceIdiom == .pad ? Color.blue : Color.clear, lineWidth: 2)
        )
        .frameInfo(color: Color.yellow, "")
        }
        
    }
}

extension View {
    func mainScreenModifier() -> some View {
        modifier(MainScreenViewModifier())
    }
}
