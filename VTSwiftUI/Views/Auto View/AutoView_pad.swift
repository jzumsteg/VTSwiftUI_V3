//
//  AutoView3.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 4/8/22.
//

import SwiftUI

struct AutoView_pad: View {
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
    
    var borderLineWidth = 1.0
    var borderColor = UIDevice.current.userInterfaceIdiom == .pad ? Color("ButtonBorder") : Color.clear
    
    
    init(showAnswerSwitch: Binding<Bool>) {
        Log.print("AutoView init", logLevel: 2)
        self._showAnswerSwitch = showAnswerSwitch
    }
    var body: some View {
        ZStack {
            // this button covers all the area around the verbtrainer view, so thaton an iPad, a touch anywhere works.
            Button(action: {
                Log.print("Outer answer switch pressed")
                showAnswerSwitch.toggle()
                if showAnswerSwitch == false {
                    verbGenerator.getVerb()
                }
            })
            {
                Text("")
                    .font(.system(size: 16, weight: .medium , design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .zIndex(0)
            ZStack  (alignment: .top) {  // this sgtack is just to get a border drawn outside the working border
                VStack {
                    GeometryReader {g in
                        ZStack {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    VStack {
                                            VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                                                .environmentObject(verbGenerator)
                                                .environmentObject(environmentals)

                                                .frame(height: 250.0)
                                                .fixedSize(horizontal: false, vertical: true)
                                            
                                            VerbAnswerView(answer: model.displayAnswer, translation: model.displayTranslation)
                                                .background(Color.clear)

                                    } // VStack:58

                                    //                                .border(Color.green)
                                    Spacer()
                                } // HStack:56
                                .zIndex(0)
                                Spacer()
                            } // VStack:54
                            //                            .border(Color.red)
                            
                            Button(action: {
                                Log.print("Inner answer switch pressed")
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
                        }  // ZStack:53
                        .zIndex(1)
                        // GeometryReader:52
                        
                        HStack {
                            Spacer()
                            AutoViewSettingsButtonView(showAutoSettingsView: $showAutoSettingsView, modeString: environmentals.drillSource)
                                .environmentObject(model)
                            //                    .border(Color.red)
                                .frame(width: 120, height: 90, alignment: .top)
                                .zIndex(2)
                        } // HStack:100
                        
                        
                        .sheet(isPresented: $showAutoSettingsView) {
                            AutoSettingsView(closeSwitch: $showAutoSettingsView)
                                .environmentObject(verbGenerator)
                                .environmentObject(model)
                        } // .sheet:109
                        
                        .zIndex(2)
                        
                    } // VStack:51
                    .zIndex(1)
                    
                    .sheet(isPresented: $showAutoSettingsView) {
                        AutoSettingsView(closeSwitch: $showAutoSettingsView)
                            .environmentObject(verbGenerator)
                            .environmentObject(model)
                    } // .sheet:127
                    
                }
//                .fullSizeFrameModifier()
                .onAppear {
                    Log.print(".onAppear")
                    Params.shared.selectedTab = "auto"
                    environmentals.selectedTab = "auto"
                    self.model.setup(verbGenerator: verbGenerator)
                    self.model.newVerb()
                }
                .onDisappear {
                    model.invalidateTimers()
                }

                .zIndex(0)
            } // ZStack:34
            
        } // varbody:someView:33
//                        .padding(.top, 75) // this drives the whole display down
        .fullSizeFrameModifier()
//        .frameSize(color: Color.red)
    }
}
    
    //struct AutoView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        AutoView()
    //    }
    //}
