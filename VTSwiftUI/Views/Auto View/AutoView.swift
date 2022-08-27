//
//  AutoView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/30/22.
//

import SwiftUI

struct AutoView: View {
    //    @EnvironmentObject var verbGenerator: VerbGenerator
    var verbGenerator = VerbGenerator.shared
    @EnvironmentObject var environmentals:CurrentEnvironmentalObjects
    
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
        VStack {
            GeometryReader { geometry in
                ZStack (alignment: .top) {
                    VStack {
                        PrintFromView("AutoView. width: \(geometry.size.width), height: \(geometry.size.height)")
                        VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                            .frame(height: geometry.size.height * 0.5)
                            .padding(.top, 10)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
                        //                        .background(Color.gray)
                        
                        HStack {
                            Spacer()
                            
                            VerbAnswerView(answer: model.displayAnswer, translation: model.displayTranslation)
                                .background(Color.clear)
                                .padding(.top, -25)
                            //                        .padding(.leading, 20)
                            Spacer()
                        } // HStack:46
                     // VStack:37
                    .frame(height: geometry.size.height * 1.0)
                    .frame(width: geometry.size.width * 0.9)
                    
                    //                .frame(minWidth: geometry.size.width * 0.75, idealWidth: geometry.size.width * 0.75, maxWidth: geometry.size.width * 0.95, minHeight: geometry.size.height * 0.38, idealHeight: geometry.size.height * 0.4, maxHeight: geometry.size.height * 0.5, alignment: .center)
                    
                    .background(Color("baseViewBackground"))

                    

                    Button(action: {
                        Log.print("model.displayAnswer: '\(model.displayAnswer)'", logLevel: 2)
                        model.invalidateTimers()
                        if model.displayAnswer == "" {
                            model.displayAnswer = model.displayVerb.answer
                            model.showAnswer()
                        }
                        else {
                            Log.print("modelDisplayAnswer must not have been empty: \(model.displayAnswer)", logLevel: 2)
                            model.verbgen?.getVerb()
                            model.displayAnswer = ""
                        }
                    }) {
                        Text("")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.clear)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    }
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "ellipsis.rectangle")
                                .padding(.top, 15)
                                .padding(.trailing, 20)
                                .font(.system(size: 36.0))
                                .foregroundColor(Color.gray)
                                .onTapGesture {
                                    Log.print("tapped")
                                    showAutoSettingsView = true
                                }
                        } // HStack:85
                        Spacer()
                    } // VStack:84
                }  // ZStack:36
                .frame(minWidth: 350.0, idealWidth: geometry.size.width * 0.95, maxWidth: 600.0, minHeight: 400.0, idealHeight: geometry.size.height, maxHeight: geometry.size.height + 1.0, alignment: .center)
                //            .padding(.trailing, 35)
            } // GeometryReader:35
            Text ("")
                .frame(height: 90.0)
                .background(Color("baseViewBackground"))

        } // VStack:34
        .frame(maxWidth: 600, maxHeight: 800)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .border(Color.gray)
        
        .sheet(isPresented: $showAutoSettingsView) {
            AutoSettingsView(closeSwitch: $showAutoSettingsView)
                .environmentObject(verbGenerator)
                .environmentObject(model)
        } // .sheet:113
        .onAppear {
            _ = PrintFromView("AutoView .onAppear")
            Log.print("AutoView.onAppear", logLevel: 2)
            Params.shared.selectedTab = "auto"
            self.model.setup(verbGenerator: verbGenerator)
            self.model.newVerb()
            //            model.startTimers()
        }
        .onDisappear {
            _ = PrintFromView("AutoView .onDisappear")
            model.invalidateTimers()
        }
    } // varbody:someView:33
    
    func showAnswer() {
        showAnswerSwitch = true
    }
    func showQuiz () {
        Log.print("")
    }
    
    
}
//
//struct AutoView_Previews: PreviewProvider {
//    static var previews: some View {
//        AutoView()
//    }
//}
