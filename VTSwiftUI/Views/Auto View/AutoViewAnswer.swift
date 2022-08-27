//
//  AutoViewAnswer.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/1/22.
//

import SwiftUI

struct AutoViewAnswer: View {
    var answer: String
    @Binding var showAnswerSwitch: Bool
    @EnvironmentObject var verbGenerator: VerbGenerator
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                Text("\(answer)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                //                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.85, alignment: .center)
                    .background(Color("AnswerFieldBackground"))
                    .foregroundColor(Color("AnswerFieldForeground"))
                    .cornerRadius(10.0)
                
                Text("\(showAnswerSwitch ? verbGenerator.displayVerb.translation : "")")
                    .verbTranslationStyle()
                //                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.15, alignment: .center)
                    .border(Color.red)
                
                
            } // VStack:17
            // GeometryReader:16
        } // varbody:someView:15
    }
}

