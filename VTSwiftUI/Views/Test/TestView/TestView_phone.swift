//
//  DrillView2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/28/22.
//

import SwiftUI

enum TestMode {
    case running
    case notRunning
}

enum NotRunningButtonClicks {
    case start
    case settings
    case history
}
enum RunningButtonClicks {
    case right
    case wrong
    case stop
}
struct TestView_phone: View {
    
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
    @State var enableAnswerButtons: Bool = false
    
    @State var showAnswerSwitch: Bool = false
    
    var whichView: view_displayed = .drill
    var borderLineWidth = 1.0
    var borderColor = UIDevice.current.userInterfaceIdiom == .pad ? Color("ButtonBorder") : Color.clear
    
    var body: some View {
        ZStack (alignment: .top) {
            GeometryReader {g in
                ZStack {
                    VStack {
                        VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
                        //                            .border(Color.blue)
                            .frame(height: 250.0)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VerbAnswerView(answer: showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: showAnswerSwitch))
                            .environmentObject(environmentals)
                            .frame(height: g.size.height * 0.45)
                            .onTapGesture {

                                Log.print(".onTap, showAnswerSwitch: \(showAnswerSwitch)")
                                if showAnswerSwitch == false  {
                                    showAnswerSwitch = true
                                    enableAnswerButtons = false
                                    verbGenerator.getVerb()
                                }
                            }
                        //                                        .frameSize(color: .red)
                        
                        //                                } // vstack
                        //                                .border(Color.green)
                        Spacer()
                    } // hstack
                    .zIndex(0)
                    Spacer()
                    //                        } // vstack
                    //                            .border(Color.red)
                    
//                    Button(action: {
//                        Log.print("Inner answer switch pressed")
//                        showAnswerSwitch.toggle()
//                        if showAnswerSwitch == false {
//                            verbGenerator.getVerb()
//                            model.addToStack(verb: verbGenerator.displayVerb)
//                        }
//                    }) {
//                        Text("")
//                            .font(.system(size: 16, weight: .medium , design: .rounded))
//                            .padding()
//                            .background(Color.clear)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    }
                    //                            .border(Color.green)
                }  // zstack
//                .frameSize(color: Color.green)
                .zIndex(1)
            }// geometryReader g
                VStack {
                    Spacer()
                    //                PrintFromView("testDone: \(testEnv.testDone)")
                    if showStartButtons == true {
                        TestStartButtons(showStartButtons: $showStartButtons, showAnswerSwitch: $showAnswerSwitch, enableAnswerButtons: $enableAnswerButtons)
                            .environmentObject(testModel)
                            .environmentObject((testEnv))
                            .frame(height: 75)
                            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 700 : UIScreen.main.bounds.width * 0.90)
                        //                                .background(Color.red).opacity(0.05)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    
                    else {
                        TestRunningButtons(showStartButtons: $showStartButtons, showAnswerSwitch: $showAnswerSwitch, enableAnswerButtons: $enableAnswerButtons)
                            .environmentObject(testModel)
                            .environmentObject((testEnv))
                            .frame(height: 75)
                            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 700 : UIScreen.main.bounds.width * 0.90)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                } // VStack:129
                
                .onAppear {
                    self.model.setup(environmentals )
                    showAnswerSwitch = false
                }
                //                    .zIndex(2)
//            } // VStack:76
            
            .zIndex(1)
            
            //            } // ZStack:75
            .zIndex(1)
            
            VStack {
                HStack {
                    Spacer()
                    DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource)
                    //                    .border(Color.red)
                        .frame(width: 120, height: 90, alignment: .top)
                        .zIndex(2)
                } // HStack:169
                Spacer()
                
            }
            .zIndex(2)
            .onAppear {
                showAnswerSwitch = false
                Params.shared.selectedTab = "test"
                environmentals.selectedTab = "test"
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
        //        .fullSizeFrameModifier()
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
