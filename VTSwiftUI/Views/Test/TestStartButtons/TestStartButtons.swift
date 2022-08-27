//
//  TestStartButtons.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/15/22.
//

import SwiftUI

struct TestStartButtons: View {
    @Binding var showStartButtons: Bool
    @Binding var showAnswerSwitch: Bool
    @Binding var enableAnswerButtons: Bool

    @EnvironmentObject var model: TestViewModel
    @EnvironmentObject var testEnv: TestEnvironment
    
    @State var showSettingsView: Bool = false
    @State var showHistoryView: Bool = false

    
    var fontSize = 16.0
    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    Log.print("Start clicked")
                    showStartButtons = false
                    testEnv.testDone = false
                    testEnv.showAnswerSwitch = false
                    model.startTest()
                    showStartButtons = false
                    showAnswerSwitch = false
                    enableAnswerButtons = true
                }) {
                    Text("Start")
                        .font(.system(size: fontSize))
                    
                }
                .buttonStyle(RoundedRectangleButtonStyle())
                .padding(.leading, 10)
            } // HStack:22
            HStack {
                Button(action: {
                    Log.print("Settings clicked")
                    showSettingsView = true
                    enableAnswerButtons = false

                }) {
                    Text("Settings")
                        .font(.system(size: fontSize))
                    
                }
                .buttonStyle(RoundedRectangleButtonStyle())
                .padding(.leading, 10)
            } // HStack:36
            
            HStack {
                Button(action: {
                    Log.print("History clicked")
                    showHistoryView = true
                    enableAnswerButtons = false
                }) {
                    Text("History")
                        .font(.system(size: fontSize))
                    
                }
                .buttonStyle(RoundedRectangleButtonStyle())
                .padding(.leading, 10)

            } // HStack:50
        } // HStack:21
//        .border(Color.blue)
//        .padding(.top, -32)
        .padding(.bottom, 20)
        
        .sheet(isPresented: $showSettingsView) {
            TestSettingsView(closeSwitch: $showSettingsView)
        } // .sheet:67
        .sheet(isPresented: $showHistoryView) {
            HistoryView(closeSwitch: $showHistoryView)
        } // .sheet:70

    } // varbody:someView:20
    

}


//struct TestStartButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        TestStartButtons()
//    }
//}
