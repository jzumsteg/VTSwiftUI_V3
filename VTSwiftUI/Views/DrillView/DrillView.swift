//
//  DrillView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/11/21.
//

import SwiftUI

struct DrillView1: View {
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var environmentals:EnvironmentalObjects
    @StateObject var model = DrillViewModel()
    
    @State private var showVerbSelectionModeView: Bool = false
    @State var verbSelectionMode = Params.shared.verbSelectMode
    @State var showDrillSettingsView: Bool = false

    @Binding var showAnswerSwitch: Bool
    var whichView: view_displayed = .drill
    
    
    init(showAnswerSwitch: Binding<Bool>) {
        Log.print("DrillView init", logLevel: 2)
        self._showAnswerSwitch = showAnswerSwitch
    }
    
    var body: some View {
              
        VStack {
            GeometryReader { geometry in
                ZStack (alignment: .top) {
                        VStack {
                        VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                            .padding(.top, 10)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
//                            .border(Color.blue)
                        VerbAnswerView(answer: showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: showAnswerSwitch))
                            .environmentObject(environmentals)
                        //                            .padding(.top, -25)
                        
                        
                    } // VStack:33
                    .zIndex(0)
                    .frame(height: geometry.size.height * 1.0)
                    .frame(width: geometry.size.width * 0.9)
                    
                    Button(action: {
                        showAnswerSwitch.toggle()
                        if showAnswerSwitch == false {
                            verbGenerator.getVerb()
                            model.addToStack(verb: verbGenerator.displayVerb)
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
                    
                    HStack {
                        Spacer()

                    DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource ?? "Unknown source")
//                    .border(Color.red)
                    .frame(width: 100, height: 90, alignment: .top)
                    } // HStack:65
                    .zIndex(2)
//                    .frame(minWidth: 350.0, idealWidth: geometry.size.width * 0.95, maxWidth: 600.0, minHeight: 400.0, idealHeight: geometry.size.height, maxHeight: geometry.size.height + 1.0, alignment: .center)

                } // ZStack:32
                
            } // GeometryReader:31

            Spacer()
            
            VStack {
                VerbDisplayButtonsView(verbSelectMode: $verbSelectionMode, showAnswerSwitch: $showAnswerSwitch)
                .environmentObject(environmentals)
                .environmentObject(model)
//                .border(Color.pink)
                .padding(.bottom, -20)
            
            

//                Spacer()
                Text("\(showAnswerSwitch ? "Touch anywhere for new verb" : "Touch anywhere for answer")")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.gray)
                    .frame(maxHeight: 20, alignment: .bottom)
                    .padding(.bottom, 15)
            } // VStack:81
            .frame(height: 110)
            .fixedSize(horizontal: true, vertical: true)
//            .border(Color.gray)
        } // VStack:30
        .zIndex(2)  // moves the view settings button to the top so it works
        .frame(maxWidth: 600, maxHeight: 800)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .border(Color.gray)
        .onAppear {
            self.model.setup(environmentals )
        }
        
        .sheet(isPresented: $showVerbSelectionModeView) {
            SelectDrillSourceView(closeSwitch:  $showVerbSelectionModeView)
                .environmentObject(environmentals)
            
        } // .sheet:110
        
    } // varbody:someView:28
}

//struct DrillView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrillView()
//    }
//}
