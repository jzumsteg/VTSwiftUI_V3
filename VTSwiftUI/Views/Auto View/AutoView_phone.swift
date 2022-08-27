//
//  DrillView2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/28/22.
//

import SwiftUI

struct AutoView_phone: View {
    var verbGenerator = VerbGenerator.shared
    @EnvironmentObject var environmentals:EnvironmentalObjects
    
    @StateObject private var model: AutoViewModel = AutoViewModel()
    
    @Binding var showAnswerSwitch: Bool {
        didSet {
            Log.print("showAnswerSwith: \(showAnswerSwitch)", logLevel: 2)
        }
    }
    @State private var showAutoSettingsView: Bool = false
    @State private var displayMode: DisplayMode = .quizShowing
//    @State private var closeSettingsSwitch: Bool = false
    
    var showAnswerFieldOn: Bool = false
    
    init(showAnswerSwitch: Binding<Bool>) {
        Log.print("AutoView init", logLevel: 2)
        self._showAnswerSwitch = showAnswerSwitch
    }

    var body: some View {
        ZStack (alignment: .top) {
            GeometryReader { geo in
                ZStack (alignment: .top) {
                    VStack {
                        VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
//                            .border(Color.blue)
                            .frame(height: 250.0)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VerbAnswerView(answer: model.displayAnswer, translation: model.displayTranslation)
                            .background(Color.clear)
//                            .border(Color.red)
                    } // VStack:37
                    .zIndex(0)
                    .padding(.bottom, 100)
                    
                    Button(action: {
                        showAnswerSwitch.toggle()
                        if showAnswerSwitch == false {
                            verbGenerator.getVerb()
                        }
                    }) {
                        Text("")
                            .font(.system(size: 16, weight: .medium , design: .rounded))
                            .padding()
                            .background(Color.clear)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    .zIndex(1)
                } // ZStack:36
//                .padding(.leading, 15)
//                .padding(.trailing, 15)
//                .border(Color.brown)

            } // GeometryReader:35
            
            HStack {
                Spacer()
                AutoViewSettingsButtonView(showAutoSettingsView: $showAutoSettingsView , modeString: environmentals.drillSource)
                //                    .border(Color.red)
                    .frame(width: 100, height: 90, alignment: .top)
                    .zIndex(2)
            } // HStack:73
        

            .sheet(isPresented: $showAutoSettingsView) {
                AutoSettingsView(closeSwitch: $showAutoSettingsView)
                    .environmentObject(verbGenerator)
                    .environmentObject(model)
            } // .sheet:82

            
        } // ZStack:34
        .frame(width: UIScreen.main.bounds.width * 0.95)
//        .frame(height: UIScreen.main.bounds.height)
        .padding(.bottom, 10)

//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color(UIDevice.current.userInterfactIdiom == .pad ? .clear :"ViewBorder"), lineWidth: 2)
//        )
        .onAppear {
            Params.shared.selectedTab = "auto"
            environmentals.selectedTab = "auto"
            self.model.setup(verbGenerator: verbGenerator)
            self.model.newVerb()
        }
        .onDisappear {
//            _ = PrintFromView("AutoView .onDisappear")
            model.invalidateTimers()
        }
        
    } // varbody:someView:32
    
} // struc



//struct AutoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrillView(showAnswerSwitch: .constant(false))
//    }
//}


/*
 ZStack (alignment: .top) {
 GeometryReader {geometry in
 VStack { // zstack, bottom layer - var height, because of answerview
 // verbDisplayView - set height
 // verb answerview - variable height
 // bottom buttons
 } // VStack:124
 
 } // GeometryReader:123
 
 // answerButton - in zstack middle layer - fills screen to bottom buttons
 // settings button - zstack, top layer -- fixed height, at bottom
 
 }  // ZStack:122
 */
