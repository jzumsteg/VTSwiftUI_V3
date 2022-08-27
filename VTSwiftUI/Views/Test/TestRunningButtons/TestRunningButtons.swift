//
//  TestRunningButtons.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/15/22.
//

import SwiftUI

struct TestRunningButtons: View {
    @Binding var showStartButtons: Bool
    @Binding var showAnswerSwitch: Bool
    @Binding var enableAnswerButtons: Bool
    @EnvironmentObject var testEnv: TestEnvironment
    @EnvironmentObject var model: TestViewModel
    
    @State var showEndingAlert: Bool = false
    
    
//    var testModel = TestViewModel()
    
    let fontSize = CGFloat(14)
    let buttonHeight = 15.0
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        model.clickedRight()
                        model.verbGenerator.getVerb()
                        showAnswerSwitch = false
                        enableAnswerButtons = true
                        
                    }) {
                        Text("Right")
                            .font(.system(size: fontSize))
                        
                    }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .frame(height:buttonHeight)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, 10)
                    .disabled(showAnswerSwitch == false)
                    .opacity(showAnswerSwitch ? 1 : 0.5)
                } // HStack:25
                HStack {
                    Button(action: {
                        model.clickedWrong()
                        model.verbGenerator.getVerb()
                        showAnswerSwitch = false
                        enableAnswerButtons = true
                    }) {
                        Text("Wrong")
                            .font(.system(size: fontSize))
                        
                    }
                    .frame(height:buttonHeight)
                    .fixedSize(horizontal: false, vertical: true)
                    .disabled(showAnswerSwitch == false)
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .padding(.leading, 10)
                    .opacity(showAnswerSwitch ? 1 : 0.5)

                } // HStack:42
                
                HStack {
                    Button(action: {
                        model.stopTest()
                        showStartButtons = true
                        showEndingAlert = true
                        testEnv.testDone = true
                        enableAnswerButtons = false
                    }) {
                        Text("Stop")
                            .font(.system(size: fontSize))
                    }
                    .frame(height:buttonHeight)
                    .fixedSize(horizontal: false, vertical: true)
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .padding(.leading, 10)
                    .opacity(showStartButtons ? 0 : 1)


                } // HStack:59
                
            } // HStack:24
            HStack {
                Text("Seconds remaining: \(model.secsRemaingStr)")
                    .font(.system(size: 13))
                Text("Tests remaining: \(model.testsRemainingStr)")
                    .font(.system(size: 13))
            } // HStack:77
            .frame(height:buttonHeight)
            .fixedSize(horizontal: false, vertical: true)
            Text(showAnswerSwitch == true ? "Tap Right or Wrong to record score and get next test" : "Tap screen for answer")
                .font(.system(size: 15))
                .foregroundColor(.red)
                .italic()
                .frame(height:buttonHeight)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 7)
                .padding(.bottom, 10)
//                .border(Color.red)
        } // VStack:23
        .frame(height:50)
        .fixedSize(horizontal: false, vertical: true)
        .onAppear {
            model.setup()
        }
        
    } // varbody:someView:22
}

//struct TestRunningButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        TestRunningButtons()
//    }
//}
