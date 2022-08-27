//
//  DrillView2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/28/22.
//

import SwiftUI

struct DrillView2: View {
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var environmentals:EnvironmentalObjects
    @StateObject var model = DrillViewModel()
    
    @State private var showVerbSelectionModeView: Bool = false
    @State var verbSelectionMode = Params.shared.verbSelectMode
    @State var showDrillSettingsView: Bool = false
    
    @Binding var showAnswerSwitch: Bool
    
    
    init(showAnswerSwitch: Binding<Bool>) {
        Log.print("DrillView init", logLevel: 2)
        self._showAnswerSwitch = showAnswerSwitch
    }
    
    
    
    var body: some View {
        
        ZStack {
            // this button covers all the area around the verbtrainer view, so thaton an iPad, a touch anywhere works.
            Button(action: {
                showAnswerSwitch.toggle()
                if showAnswerSwitch == false {
                    verbGenerator.getVerb()
                    model.addToStack(verb: verbGenerator.displayVerb)
                }
            }) {
                Text("")
                    .font(.system(size: 16, weight: .medium , design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
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
                            
                            VerbAnswerView(answer: showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: showAnswerSwitch))
                                .environmentObject(environmentals)
                            //                            .border(Color.red)
                            
//                            Text("showAnswerSwitch: \(showAnswerSwitch ? "true" : "false")")
                        } // VStack:47
                        .zIndex(0)
                        .padding(.bottom, 100)
                        
                        Button(action: {
                            showAnswerSwitch.toggle()
                            if showAnswerSwitch == false {
                                verbGenerator.getVerb()
                                model.addToStack(verb: verbGenerator.displayVerb)
                            }
                        }) {
                            Text("")
                                .font(.system(size: 16, weight: .medium , design: .rounded))
                                .padding()
                                .background(Color.clear)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                        .zIndex(1)
                    } // ZStack:46
                    //                .padding(.leading, 15)
                    //                .padding(.trailing, 15)
                    //                .border(Color.brown)
                    

                
                VStack {
                    Spacer()
                    VerbDisplayButtonsView(verbSelectMode: $verbSelectionMode, showAnswerSwitch: $showAnswerSwitch)
                        .environmentObject(environmentals)
                        .environmentObject(model)
//                        .border(Color.gray)
                        .frame(width: geo.size.width)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, -20)
                    
                } // VStack:84
                .zIndex(2)
                //            .border(Color.green)
                //            .background(Color.green)
                } // GeometryReader:45
                
                HStack {
                    Spacer()
                    DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource)
                    //                    .border(Color.red)
                        .frame(width: 100, height: 90, alignment: .top)
                        .zIndex(2)
                } // HStack:100
                .sheet(isPresented: $showVerbSelectionModeView) {
                    SelectDrillSourceView(closeSwitch:  $showVerbSelectionModeView)
                        .environmentObject(environmentals)
                } // .sheet:107
                
                
            } // ZStack:44
            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 600 : UIScreen.main.bounds.width * 0.90)
            .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 700 : UIScreen.main.bounds.height * 0.85)

        } // ZStack:29
        .onAppear {
            environmentals.selectedTab = "drill"
            Params.shared.selectedTab = "drill"
        }

        .padding(.bottom, 10)


    } // varbody:someView:27
    
} // struc



//struct DrillView2_Previews: PreviewProvider {
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
 } // VStack:139
 
 } // GeometryReader:138
 
 // answerButton - in zstack middle layer - fills screen to bottom buttons
 // settings button - zstack, top layer -- fixed height, at bottom
 
 }  // ZStack:137
 */
