//
//  SettingsButtonView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/22/22.
//

import SwiftUI

struct SettingsButtonView: View {
    var captionStr: String
    var imageStr: String
    var imageSize = 30.0
    var textFontSize = 12.0
    
    init(captionStr: String, imageStr: String) {
        if (UIDevice().name.lowercased().contains("iphone se") ||  UIDevice().name.lowercased().contains("iphone 5")) {
            textFontSize = 9
        }
        
        if UIDevice().name.lowercased().contains("ipad") {
            imageSize = 48.0
            textFontSize = 24
        }
        
        self.captionStr = captionStr
        self.imageStr = imageStr
    }
    
    var body: some View {
      VStack {
            Image(systemName: imageStr)
                .font(.system(size: imageSize))
                .foregroundColor(Color("ViewForeground"))
//                .padding(.bottom, 2)
                .padding(.top, 5)
            Text(captionStr)
                .font(.system(size: textFontSize))
                .frame(height:30)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color("ViewForeground"))
        } // VStack:26
        .background(Color.clear)
        .fixedSize(horizontal: false, vertical: true)
    } // varbody:someView:25
}

//struct SettingsButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsButtonView()
//    }
//}
