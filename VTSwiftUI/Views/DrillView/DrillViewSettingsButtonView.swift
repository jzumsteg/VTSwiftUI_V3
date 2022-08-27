//
//  DrillViewSettingsButtonView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/14/22.
//

import SwiftUI

struct DrillViewSettingsButtonView: View {
    @Binding var showVerbSelectionModeView: Bool
    var modeString: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "ellipsis.rectangle")
                    .padding(.top, 15)
                    .padding(.trailing, 40)
            
                    .font(.system(size: 36, weight: .light , design: .rounded))
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        Log.print("tapped settings button")
                        showVerbSelectionModeView = true
                    }
            } // HStack:16
            Text(modeString)
                .foregroundColor(Color("LabelText"))
                .font(.system(size:14))
        } // VStack:15
    } // varbody:someView:14
}

struct DrillViewSettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DrillViewSettingsButtonView(showVerbSelectionModeView: .constant(true), modeString: "modeString")
    }
}
