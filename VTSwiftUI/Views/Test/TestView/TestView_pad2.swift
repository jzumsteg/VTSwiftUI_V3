//
//  TestView_pad.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/28/22.
//

import SwiftUI

struct TestView_pad2: View {
    
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
    @State var disableAnswerButton : Bool = true
    
    @State var showAnswerSwitch: Bool = false
    
    var whichView: view_displayed = .drill
    var borderLineWidth = 1.0
    var borderColor = UIDevice.current.userInterfaceIdiom == .pad ? Color("ButtonBorder") : Color.clear
    
    var body: some View {
        ZStack (alignment: .top) {   // zstack 1
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
            VStack {
                Spacer()
                VStack {
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
                        //                            .frame(height: g.size.height * 0.45)
                        //                                        .frameSize(color: .red)
                        
                        //                                } // vstack
                        //                                .border(Color.green)
                        Spacer()
                        
                    }
//                    .frame(width: 500.0, height: 500.0, alignment: .center)
                    .frameSize(color: .red, "VStack")
                    Spacer()
                    VStack {
                        Spacer()
                        //                PrintFromView("testDone: \(testEnv.testDone)")
                        if showStartButtons == true {
                            TestStartButtons(showStartButtons: $showStartButtons, showAnswerSwitch: $showAnswerSwitch)
                                .environmentObject(testModel)
                                .environmentObject((testEnv))
                                .frame(height: 75)
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 700 : UIScreen.main.bounds.width * 0.90)
                            //                                .background(Color.red).opacity(0.05)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        
                        else {
                            TestRunningButtons(showStartButtons: $showStartButtons, showAnswerSwitch: $showAnswerSwitch)
                                .environmentObject(testModel)
                                .environmentObject((testEnv))
                                .frame(height: 75)
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 700 : UIScreen.main.bounds.width * 0.90)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    } // VStack:129

                }
                .padding(15)
                .fullSizeFrameModifier()
                .frameSize(color: .blue, "VStack")
                Spacer()
                
                .onAppear {
                    self.model.setup(environmentals )
                    showAnswerSwitch = false
                }
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
            } // .sheet:212
            
        } // ZStack:56
        .frameSize(color: .red, "zStack")
        
        .frame(width: UIScreen.main.bounds.width * 0.95)
        
        .onAppear{
            showAnswerSwitch = false}
    } // varbody:someView:55
    
    
    
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
 } // VStack:239
 
 } // GeometryReader:238
 
 // answerButton - in zstack middle layer - fills screen to bottom buttons
 // settings button - zstack, top layer -- fixed height, at bottom
 
 }  // ZStack:237
 */
