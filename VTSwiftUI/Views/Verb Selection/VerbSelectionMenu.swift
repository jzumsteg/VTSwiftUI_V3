//
//  FilterMenu.swift
//  Wordtrainer
//
//  Created by John Zumsteg on 10/25/21.
//

import SwiftUI
struct VerbSelectionMenu: View {
//    @Binding var redraw: Bool
    @State private var myId = 0
//    @Binding var noFilterSelected: Bool
    var titleFontSize = CGFloat(36)
    var checkmarkFontSize = CGFloat(36)
    var buttonFontSize = CGFloat(18)
    var buttonWidth = CGFloat(200.0)
    var buttonHeight = CGFloat(35)
    var topPadding = CGFloat(12)
    var body: some View {
        ZStack {
            VStack {
            Text("Set Word Selection Filter")
                .padding()
                .font(.system(size: 28))
                VerbSelectionRow(filterName: .constant("Nouns"))
                VerbSelectionRow(filterName: .constant("Verbs"))
            } // VStack:21
        } // ZStack:20
    }  // varbody:someView:19
} // struct



struct VerbSelectionSideMenu: View {
    @State private var noFilterSelected: Bool = false
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void  // this says to invoke menuClose in the calling function

    var body: some View {
        ZStack {
            GeometryReader { _ in
                HStack {
                    VerbSelectionMenu()
                        .frame(width: self.width - 20.0 , height: 220.0)
//                        .border(Color.gray)
                        .background(Color.clear)
                        .offset(x: self.isOpen ? 0 : -self.width)
                        .animation(Animation.easeOut.delay(0.25))
                        .padding()
                }  // HStack:43
            } // GeometryReader:42
            .background(Color.gray.opacity(0.01))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
//            .onTapGesture {
//                self.menuClose()
//            }
            Spacer()
            .alert(isPresented: $noFilterSelected) {
                Alert(title: Text("Error"), message: Text("You must selected at least one grade to show on the map."), dismissButton: .default(Text("Ok")))
            }

            
        } // ZStack:41
//        .background(Color.clear)
//        Spacer()
    } // varbody:someView:40
}


