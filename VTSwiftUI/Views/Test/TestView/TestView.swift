//
//  TestView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/15/22.
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
struct TestView: View {
    
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var environmentals:CurrentEnvironmentalObjects
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
    
    @Binding var showAnswerSwitch: Bool
    
    var whichView: view_displayed = .drill

//    init(showAnswerSwitch: Binding<Bool>) {
//        Log.print("TestView init", logLevel: 2)
//        //        _testEnv.showAnswerSwitch = showAnswerSwitch
//
//    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack (alignment: .top) {
                    VStack {
                        VerbDisplayView(showAnswerSwitch: $testEnv.showAnswerSwitch)
                            .padding(.top, 10)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
                        //                            .border(Color.blue)
                        VerbAnswerView(answer: testEnv.showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: testEnv.showAnswerSwitch))
                            .environmentObject(environmentals)
                        //                            .padding(.top, -25)
                        
                        
                    } // VStack:62
                    PrintFromView("\(geometry.size.width), \(geometry.size.height)")

                    .zIndex(0)
                    .frame(height: geometry.size.height * 1.0)
                    .frame(width: geometry.size.width * 0.9)
                    
                    Button(action: {
                        testEnv.showAnswerSwitch.toggle()
                        if !testEnv.showAnswerSwitch {
                            verbGenerator.getVerb()
                        }
                    }) {
                        Text("")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.clear)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .zIndex(1)
                    //                    .border(Color.green)
                    .disabled(testEnv.showAnswerSwitch == true)
                    HStack {
                        Spacer()

                        DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource ?? "Unknown source")
                        //                    .border(Color.red)
                            .frame(width: 100, height: 90, alignment: .top)
                    } // HStack:95
                    .zIndex(2)
                    
                } // ZStack:61
                .frame(minWidth: geometry.size.width * 0.90, idealWidth: geometry.size.width * 0.95, maxWidth: geometry.size.width * 0.98)
                .frame(maxHeight: 525.0)
                //                .border(Color.gray)
                
            } // GeometryReader:60
            //            if showStartButtons == true {
            PrintFromView("testDone: \(testEnv.testDone)")
            if showStartButtons == true {
                TestStartButtons(showStartButtons: $showStartButtons)
                    .environmentObject(testModel)
                    .environmentObject((testEnv))
                    .frame(height: 110)
                    .frame(width: 300)

                    .fixedSize(horizontal: true, vertical: true)
            }
            else {
                TestRunningButtons(showStartButtons: $showStartButtons)
                    .environmentObject(testModel)
                    .environmentObject((testEnv))
                    .frame(height: 110)
                    .frame(width: 300)
                    .fixedSize(horizontal: true, vertical: true)
            }
            
        } // VStack:59
        .zIndex(2)  // moves the view settings button to the top so it works
        //        .border(Color.gray)
        .frame(maxWidth: 600, maxHeight: 800)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        //        .padding(.bottom, 25)
        .border(Color.gray)
        .onAppear {
            self.model.setup(environmentals )
        }
        
        .sheet(isPresented: $showVerbSelectionModeView) {
            SelectDrillSourceView(closeSwitch:  $showVerbSelectionModeView)
                .environmentObject(environmentals)
            
        } // .sheet:142
        
        
        
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
        
    } // varbody:someView:58
    
    func startTest() {
        Log.methodEnter()
    }
    
    func stopTest() {
        Log.methodEnter()
    }
    
    func nameChanged(to value: String) {
        print("Name changed to \(value)!")
    }
    
    func history() {
        Log.methodEnter()
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(showAnswerSwitch: .constant(false))
    }
}
