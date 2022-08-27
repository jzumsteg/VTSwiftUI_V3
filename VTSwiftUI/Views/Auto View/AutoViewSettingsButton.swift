//
//  DrillViewSettingsButtonView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/14/22.
//

import SwiftUI

struct AutoViewSettingsButtonView: View {
    @Binding var showAutoSettingsView: Bool
    @EnvironmentObject var model: AutoViewModel
    var modeString: String
    
    var body: some View {
        VStack (alignment: .center) {
            HStack {
                Spacer()
                Image(systemName: "ellipsis.rectangle")
                    .padding(.top, 15)
                    .padding(.trailing, 20)
            
                    .font(.system(size: 36, weight: .light , design: .rounded))
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        Log.print("tapped settings button")
                        model.invalidateTimers()
                        showAutoSettingsView = true
                    }
                Spacer()
            } // HStack:16
            
            Text(modeString)
                .foregroundColor(Color("LabelText"))
                .font(.system(size:14))
        } // VStack:15
    } // varbody:someView:14
}

