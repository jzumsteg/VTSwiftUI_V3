//
//  DrillView_phne.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 4/6/22.
//

import SwiftUI

struct DrillView_phone: View {
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
        ZStack  (alignment: .top) {
            GeometryReader {g in
                ZStack {
                    VStack {
                        
                        VerbDisplayView(showAnswerSwitch: $showAnswerSwitch)
                            .environmentObject(verbGenerator)
                            .environmentObject(environmentals)
//                                                    .border(Color.blue)
                            .frame(height: 250.0)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VerbAnswerView(answer: showAnswerSwitch ? verbGenerator.displayVerb.answer : "", translation:  model.translationToDisplay(verb: verbGenerator.displayVerb, atAnswer: showAnswerSwitch))
                            .environmentObject(environmentals)
                            .frame(height: g.size.height * 0.45)
                        //                                        .frameSize(color: .red)
                        
                        //                                } // vstack
//                                                        .border(Color.green)
                        Spacer()
                    } // hstack
                    .zIndex(0)
                    Spacer()
                    //                        } // vstack
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
                    //                            .border(Color.green)
                }  // zstack
//                .frameSize(color: Color.green)
                .zIndex(1)
            }// geometryReader g
            
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    VerbDisplayButtonsView(verbSelectMode: $verbSelectionMode, showAnswerSwitch: $showAnswerSwitch)
                        .environmentObject(environmentals)
                        .environmentObject(model)
                    //                        .padding(.bottom, -20)
                    
                } // VStack:84
                .frame(height:100)
//                .frameSize(color: Color.gray)
                .zIndex(2)

            }
            .zIndex(1)
            
            HStack {
                Spacer()
                DrillViewSettingsButtonView(showVerbSelectionModeView: $showVerbSelectionModeView , modeString: environmentals.drillSource)
                //                    .border(Color.red)
                    .frame(width: 120, height: 90, alignment: .top)
                    .zIndex(2)
            } // HStack:100
            .zIndex(2)
            
            Spacer()
        } // hstack
        .frame(width: UIScreen.main.bounds.width * 0.95)
        //        .frame(height: UIScreen.main.bounds.height)
        .padding(.bottom, 10)
        
        
        .sheet(isPresented: $showVerbSelectionModeView) {
            SelectDrillSourceView(closeSwitch:  $showVerbSelectionModeView)
                .environmentObject(environmentals)
        } // .sheet:107
        
        .onAppear {
            Params.shared.selectedTab = "drill"
            environmentals.selectedTab = "drill"
        }
        //    .padding(.top, 75) // this drives the whole display down
        .zIndex(0)
        
    }
}

//struct DrillView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrillView(showAnswerSwitch: .constant(false))
//    }
//}
