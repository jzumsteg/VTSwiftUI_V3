//
//  DrillView_iPad.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 4/6/22.
//

import SwiftUI

struct DrillView_pad: View {
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var environmentals:EnvironmentalObjects
    @StateObject var model = DrillViewModel()
    
    @State private var showVerbSelectionModeView: Bool = false
    @State var verbSelectionMode = Params.shared.verbSelectMode
    @State var showDrillSettingsView: Bool = false
    
    @Binding var showAnswerSwitch: Bool
    
    var borderLineWidth = 1.0
    var borderColor = UIDevice.current.userInterfaceIdiom == .pad ? Color("ButtonBorder") : Color.clear
    
    
    init(showAnswerSwitch: Binding<Bool>) {
        Log.print("DrillView init", logLevel: 2)
        self._showAnswerSwitch = showAnswerSwitch
    }
    
    var body: some View {
        ZStack {
            //            GeometryReader { g in
            Button(action: {
                Log.print("Outer answer switch pressed")
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
            .zIndex(0)
            HStack {
//                PrintFromView("UIScreen.main.bounds.width: \(UIScreen.main.bounds.width), UIScreen.main.bounds.height: \(UIScreen.main.bounds.height)")
                Spacer()
                ZStack  (alignment: .top) {  //
                    VStack {
                        GeometryReader {g in
                            ZStack {
                                VStack {  // this vstack should vcenter the mainview vertically
                                    Spacer()
                                    HStack {  // this hstack centers the main view horizontally
                                        Spacer()
                                        VStack {
                                            VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                                                .environmentObject(verbGenerator)
                                                .environmentObject(environmentals)
                                                .frame(height: 250.0)
                                                .fixedSize(horizontal: false, vertical: true)
                                            VerbAnswerView(answer: showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: showAnswerSwitch))
                                                .environmentObject(environmentals)
                                            
                                            
                                        } // vstack
                                        
                                        Spacer()
                                    } // hstack
                                    //                                        .background(Color.blue).opacity(0.05)
                                    .zIndex(0)
                                    Spacer()
                                } // vstack
                                //                            .border(Color.red)
                                
                                
                                Button(action: {
                                    Log.print("Inner answer switch pressed")
                                    showAnswerSwitch.toggle()
                                    if showAnswerSwitch == false {
                                        verbGenerator.getVerb()
                                        model.addToStack(verb: verbGenerator.displayVerb)
                                        model.setStackPos(0)
                                    }
                                }) {
                                    Text("")
                                        .font(.system(size: 16, weight: .medium , design: .rounded))
                                        .padding()
                                        .background(Color.clear)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                //                                    .frameSize(color: Color.red)
                            }  // zstack
                            //                                .frameSize(color: Color.blue)
                            .zIndex(1)
                        }// geometryReader g
                        
                        VStack {
                            Spacer()
                            VerbDisplayButtonsView(verbSelectMode: $verbSelectionMode, showAnswerSwitch: $showAnswerSwitch)
                                .environmentObject(environmentals)
                                .environmentObject(model)
                            //                            .padding(.bottom, 20)
                            
                        } // VStack:84
                        .frame(height:125)
                        //                            .frameSize(color: Color.black)
                        //                    .border(Color.gray)
                        //                    .padding(.bottom, 20)
                        .zIndex(2)
                    } // vstack
                    //                        .frameSize(color: Color.yellow)
                    .zIndex(1)
                    
                    HStack {
                        Spacer()
                        DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource)
                            .frame(width: 120, height: 90, alignment: .top)
                            .zIndex(2)
                    } // HStack:100
                    //                        .frameSize(color: Color.purple)
                    .zIndex(2)
                    
                } // zstack
                
                
                .fullSizeFrameModifier()
                .zIndex(1)
                
                Spacer()
            } // hstack
            
            .sheet(isPresented: $showVerbSelectionModeView) {
                SelectDrillSourceView(closeSwitch:  $showVerbSelectionModeView)
                    .environmentObject(environmentals)
            } // .sheet:107
            //            } // geo
            
        }
        
        
        .onAppear {
            Params.shared.selectedTab = "drill"
            environmentals.selectedTab = "drill"
//            Log.print("UIScreen.main.bounds.width: \(UIScreen.main.bounds.width), UIScreen.main.bounds.height: \(UIScreen.main.bounds.height)")
        }
        
        .zIndex(0)
        
    }
}

//struct DrillView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrillView(showAnswerSwitch: .constant(false))
//    }
//}
