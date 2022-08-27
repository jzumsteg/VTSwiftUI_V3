//
//  AutoSettingsView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/30/22.
//

import SwiftUI

struct AutoSettingsView2: View {
    @State var drillInterval: Double = Double(Params.shared.drillDuration)
    @State var answerInterval: Double = Double(Params.shared.answerDuration)
    
    @Binding var closeSwitch: Bool
    
    var maxDrill: Int32 = 30
    var minDrill: Int32 = 2
    
    var maxAnswer: Int32 = 30
    var minAnswer: Int32 = 2
    
    @EnvironmentObject var autoModel: AutoViewModel
    
    init(closeSwitch: Binding<Bool>) {
        self._closeSwitch = closeSwitch
        drillInterval = Double(Params.shared.drillDuration)
        answerInterval = Double(Params.shared.answerDuration)
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "chevron.down.circle")
                    .font(.system(size: 36))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
                        closeSwitch = false
                        Log.print("Tapped close")
                    } // .onTap
            }  // HStack:33
            .zIndex(1)
            
            Text("AutoSettingsView")
                .padding(.top, 50)
                .padding(.bottom, 20)
            VStack {
                VStack {
                    Text("Drill interval: \(Int(drillInterval)) seconds")
                        .padding(.top, 25)
                    HStack {
                        Text("\(Int(minDrill)) sec.")
                        Slider(value: $drillInterval, in: Double(minDrill)...Double(maxDrill)) { newValue in
                            Log.print(drillInterval)
                            if newValue == false {
                                Log.print("New value is \(drillInterval)")
                                autoModel.drillSeconds = Int32(drillInterval)
                                Params.shared.drillDuration = Int32(drillInterval)
                            }
                        }
                        Text("\(Int(maxDrill)) sec.")
                    } // HStack:55

                } // VStack:53
                //            VStack {
                Text("Answer interval: \(Int(answerInterval)) seconds")
                
                HStack {
                    Text("\(Int(minAnswer)) sec.")
                    Slider(value: $answerInterval, in: Double(minAnswer)...Double(maxAnswer)) { newValue in
                        Log.print(drillInterval)
                        if newValue == false {
                            Log.print("New value is \(answerInterval)")
                            autoModel.answerSeconds = Int32(answerInterval)
                            Params.shared.answerDuration = Int32(answerInterval)
                        }
                    }
                    Text("\(Int(maxAnswer)) sec.")
                } // HStack:71
                //            } // VStack:68
                Spacer()
            } // VStack:32
            .padding(.leading, 25)
            .padding(.trailing, 25)
            .background(Color("BaseViewBackground"))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BlueViewBorder"), lineWidth: 1)
            )
        }
        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.width * 0.75 : UIScreen.main.bounds.width * 0.80)
        .frame(height: 250)
        
        
        .onDisappear {
            autoModel.invalidateTimers()
            autoModel.newVerb()
        }
        
        .padding(.leading, 50)
        .padding(.trailing, 50)
        Spacer()
    } // varbody:someView:31
    
}

//struct AutoSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AutoSettingsView()
//    }
//}
