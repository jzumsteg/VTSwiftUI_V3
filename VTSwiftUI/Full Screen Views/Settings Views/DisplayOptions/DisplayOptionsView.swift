//
//  DisplayOptionsView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/11/22.
//

import SwiftUI

struct DisplayOptionsView: View {
    @EnvironmentObject var environmentals: CurrentEnvironmentalObjects
    @StateObject var model: DisplayOptionsModel = DisplayOptionsModel()
    
    
    @Binding var showDisplayOptionsView: Bool
    
    
    var textFontSize = 16.0

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Display Options")
                        .viewTitleStyle()
                        .padding(.top, 15)
                        .padding(.leading, 20)

                }  // HStack:23
                GeometryReader { geo in
                    List {
                        Section(header: Text("When to show translation")) {
                            HStack {
                                Text("When drill is presented")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                if environmentals.whenTranslation == .atQuiz {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:33
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.whenTranslation = .atQuiz
                            }
                            HStack {
                                Text("When answer is presented")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                if environmentals.whenTranslation == .atAnswer {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:49
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.whenTranslation = .atAnswer
                            }
                            
                            HStack {
                                Text("Never")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                if environmentals.whenTranslation == .never {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:66
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.whenTranslation = .never
                            }
                            
                        } // section
                        
                        Section(header: Text("What translation to show")) {
                            HStack {
                                Text("Infinitive Translation")
                                    .font(.system(size: textFontSize))
                                Spacer()
                                if environmentals.whatTranslation == .infinitive {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 20.0))
                                }
                            } // HStack:86
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.whatTranslation = .infinitive
                            }
                            
                            HStack {
                                Text("Verb form translation")
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .font(.system(size: textFontSize))
                                    .contentShape(Rectangle())
                                
                                Spacer()
                                if environmentals.whatTranslation == .verbform {
                                    Image(systemName: "checkmark")
                                }
                            } // HStack:100
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.whatTranslation = .verbform
                            }
                        } // section
                        
                        Section(header: Text("What infinitive to show")) {
                            HStack {
                                Text("Language Infinitive")
                                    .font(.system(size: textFontSize))
                                Spacer()
                                if environmentals.currentInfinitiveDisplayMode == .language {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 20.0))
                                }
                            } // HStack:118
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.currentInfinitiveDisplayMode == .language
                            }
                            
                            HStack {
                                Text("English")
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .font(.system(size: textFontSize))
                                    .contentShape(Rectangle())
                                
                                Spacer()
                                if environmentals.currentInfinitiveDisplayMode == .english{
                                    Image(systemName: "checkmark")
                                }
                            } // HStack:132
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.currentInfinitiveDisplayMode = .english
                            }
                        } // section
                        
                    } // List:31
                }  // GeometryReader:30
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .onAppear {
                    self.model.setup ()
                
                .frame(minWidth: 200.0, idealWidth: 300.0, maxWidth: .infinity, minHeight: 400.0, idealHeight:450.0, maxHeight: 800.0, alignment: .center)
                
            }
        } // VStack:22

        Spacer()
    
} // ZStack:21


struct DisplayOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayOptionsView(showDisplayOptionsView: .constant(false))
    }
}
