//
//  VerbAnswerView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/1/22.
//

import SwiftUI

struct VerbAnswerView: View {
    var answer: String
    var translation: String
//    @Binding var showAnswerSwitch: Bool
//    @EnvironmentObject var verbGenerator: VerbGenerator
    
    var body: some View {
        GeometryReader {geometry in
            Spacer()
            VStack (alignment: .center) {
                Spacer()
//                PrintFromView("width: \(geometry.size.width), height: \(geometry.size.height)")
                Text("\(answer)")
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .phone ?  48 : 72, weight: .bold, design: .rounded))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.70, alignment: .topLeading)   // alighnment refers to text alignment in the text field
//                    .padding(.leading, 10)
//                    .padding(.trailing, 10)
//                    .border(Color.orange)
                    .background(Color("AnswerFieldBackground"))
                    .foregroundColor(Color("AnswerFieldForeground"))
                  .cornerRadius(10.0)
                    
                
                Text("\(translation)")
                    .verbTranslationStyle()
                    .frame(width: geometry.size.width, height: 50.0, alignment: .leading)
//                    .padding(.leading, 50)
//                    .padding(.trailing, 50)
//                    .border(Color.green)
                Spacer()
            } // VStack:19
//            Spacer()
         // GeometryReader:17
//        .border(Color.yellow)
    } // varbody:someView:16
}
}


