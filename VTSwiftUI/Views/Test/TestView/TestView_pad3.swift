//
//  TestView_pad3.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/28/22.
//

import SwiftUI

struct TestView_pad: View {
    
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var environmentals:EnvironmentalObjects
    @StateObject var testEnv: TestEnvironment = TestEnvironment()
    
    @StateObject var model = DrillViewModel()
    @StateObject var testModel = TestViewModel()
    
    @State var showVerbSelectionModeView: Bool = false
    @State var verbSelectionMode = Params.shared.verbSelectMode
    @State var showDrillSettingsView: Bool = false
    @State var testMode: TestMode = .notRunning {
        didSet {
            Log.print("testMode: \(testMode)")
        }
    }
    @State var startButtonClick: NotRunningButtonClicks = .start
    @State var runningButtonClick: RunningButtonClicks = .right
    @State var showStartButtons: Bool = true
    @State var showSettingsView: Bool = false
    @State var disableAnswerButtons : Bool = true
    @State var enableAnswerButtons : Bool = false

    @State var showAnswerSwitch: Bool = true
    
    var whichView: view_displayed = .drill
    var borderLineWidth = 1.0
    var borderColor = UIDevice.current.userInterfaceIdiom == .pad ? Color("ButtonBorder") : Color.clear
    
    var body: some View {
        ZStack (alignment: .top) {   // zstack 1
            // this button covers all the area around the verbtrainer view, so thaton an iPad, a touch anywhere works.
            Button(action: {
                Log.print("Outer answer switch pressed, showAnswerSwith: \(showAnswerSwitch)")
                showAnswerSwitch.toggle()
                enableAnswerButtons.toggle()
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
            .disabled(enableAnswerButtons == false)
            .zIndex(0)
            
            VStack {
                Spacer()
                ZStack (alignment: .top){
                    HStack {
                        Spacer()
                        DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource)
                        //                    .border(Color.red)
                            .frame(width: 120, height: 90, alignment: .top)
                            .zIndex(2)
                    } // HStack:109
//                    .frameInfo(color: .red, "Settings button")
                    Spacer()
                    VStack {
                        VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
                        //                            .border(Color.blue)
                            .frame(height: 250.0)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VerbAnswerView(answer: showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: showAnswerSwitch))
                            .environmentObject(environmentals)
                            .onTapGesture {

                                Log.print(".onTap, showAnswerSwitch: \(showAnswerSwitch)")
                                if showAnswerSwitch == false  {
                                    showAnswerSwitch = true
                                    enableAnswerButtons = false
                                    verbGenerator.getVerb()
                                }
                            }
                        Spacer()
                        if showStartButtons == true {
                            TestStartButtons(showStartButtons: $showStartButtons, showAnswerSwitch: $showAnswerSwitch, enableAnswerButtons: $enableAnswerButtons)
                                .environmentObject(testModel)
                                .environmentObject((testEnv))
                                .frame(height: 75)
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 680 : UIScreen.main.bounds.width * 0.90)
                                .fixedSize(horizontal: true, vertical: false)
                                .padding(.trailing, 20)

                             }
                        
                        
                        else {
                            TestRunningButtons(showStartButtons: $showStartButtons, showAnswerSwitch: $showAnswerSwitch, enableAnswerButtons: $enableAnswerButtons)
                                .environmentObject(testModel)
                                .environmentObject((testEnv))
                                .frame(height: 75)
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 680 : UIScreen.main.bounds.width * 0.90)
                                .fixedSize(horizontal: true, vertical: false)
                                .padding(.trailing, 30)
                        }
                    } // VStack:61
                    .padding(.leading, 9)
                    .padding(.top, 8)
//                    HStack {
//                        Spacer()
//                        DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource)
//                            .frame(width: 120, height: 90, alignment: .top)
//                            .zIndex(2)
//                    } // HStack:100
                } // VStack:59
                .padding(.leading, 8)
                .fullSizeFrameModifier()
//                .frameInfo(color: .yellow, "inner?")
                Spacer()
            } // VStack:57
            VStack {
                Spacer()
                
            } // VStack:108
            .zIndex(2)
            .onAppear {
                self.model.setup(environmentals )
                showAnswerSwitch = false
            }
            
            
            .alert(isPresented: $testModel.showAlert) {
                Alert(title: Text("Test Complete!"),
                      message: Text("# right: \(testModel.numRight), # wrong: \(testModel.numWrong), \(testModel.pctCorrect)"),
                      primaryButton: .default(Text("Save to history"), action: {
                    Log.print("save")
                    testModel.saveToHistory()
                    testModel.showAlert = false
                    showStartButtons = true
                }),
                      secondaryButton: .destructive(Text("Don't save."), action: {
                    Log.print("Cancel")
                    testModel.showAlert = false
                    showStartButtons = true
                })
                )
            }   // .alert
            
            .sheet(isPresented: $showVerbSelectionModeView) {
                SelectDrillSourceView(closeSwitch:  $showVerbSelectionModeView)
                    .environmentObject(environmentals)
            } // .sheet:144
            
            
            //        .frameSize(color: .red, "zStack")
            
            .frame(width: UIScreen.main.bounds.width * 0.95)
        } // zstack
        .onAppear{
            showAnswerSwitch = false
            
        }
    } // varbody:someView:39
    
    
    
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
 } // VStack:174
 
 } // GeometryReader:173
 
 // answerButton - in zstack middle layer - fills screen to bottom buttons
 // settings button - zstack, top layer -- fixed height, at bottom
 
 }  // ZStack:172
 */
