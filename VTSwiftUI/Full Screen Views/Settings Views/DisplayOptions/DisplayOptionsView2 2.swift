//
//  DisplayOptionsView2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/13/22.
//

import SwiftUI

struct DisplayOptionsView2: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @StateObject var model: DisplayOptionsModel = DisplayOptionsModel()    
    
    @Binding var showDisplayOptionsView: Bool
    
    var textFontSize: CGFloat = 14

    var body: some View {
        VStack {
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
                            if environmentals.translationWhen == .atQuiz {
                                Image(systemName: "checkmark")
                            }

                        } // HStack:24
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.translationWhen = .atQuiz
                        }
                        HStack {
                            Text("When answer is presented")
                                .font(.system(size: textFontSize))
                                .frame(width: geo.size.width * 0.7, alignment: .leading)
                                .contentShape(Rectangle())
                            //                            .border(Color.gray)
                            Spacer()
                            if environmentals.translationWhen == .atAnswer {
                                Image(systemName: "checkmark")
                            }

                        } // HStack:40
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.translationWhen = .atAnswer
                        }
                        
                        HStack {
                            Text("Never")
                                .font(.system(size: textFontSize))
                                .frame(width: geo.size.width * 0.7, alignment: .leading)
                                .contentShape(Rectangle())
                            //                            .border(Color.gray)
                            Spacer()
                            if environmentals.translationWhen == .never {
                                Image(systemName: "checkmark")
                            }

                        } // HStack:57
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.translationWhen = .never
                        }
                    
                        
                    } // section
                    
                    Section(header: Text("What translation to show")) {
                        HStack {
                            Text("Infinitive Translation")
                                .font(.system(size: textFontSize))
                            Spacer()
                            if environmentals.translationWhat == .infinitive {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 20.0))
                            }
                        } // HStack:78
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.translationWhat = .infinitive
                        }
                        
                        HStack {
                            Text("Verb form translation")
                                .frame(width: geo.size.width * 0.7, alignment: .leading)
                                .font(.system(size: textFontSize))
                                .contentShape(Rectangle())
                            
                            Spacer()
                            if environmentals.translationWhat == .verbform {
                                Image(systemName: "checkmark")
                            }
                        } // HStack:92
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.translationWhat = .verbform
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
                        } // HStack:110
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.currentInfinitiveDisplayMode = .language
                        }
                        
                        HStack {
                            Text("English")
                                .frame(width: geo.size.width * 0.7, alignment: .leading)
                                .font(.system(size: textFontSize))
                                .contentShape(Rectangle())
                            
                            Spacer()
                            if environmentals.currentInfinitiveDisplayMode == .english {
                                Image(systemName: "checkmark")
                            }
                        } // HStack:124
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.currentInfinitiveDisplayMode = .english
                        }
                    } // section
                    
                } // List:22
            }  // GeometryReader:21
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .onAppear {
                self.model.setup ()
            }
            .navigationBarTitle("Display Options", displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
//            .frame(minWidth: 200.0, idealWidth: 300.0, maxWidth: .infinity, minHeight: 400.0, idealHeight:450.0, maxHeight: 800.0, alignment: .center)
            .padding(.top, 50)
        }  // VStack:20
        .frame(
            width:UIScreen.main.bounds.width > 500 ? 500.0 : UIScreen.main.bounds.width,
            height:UIScreen.main.bounds.height > 800 ? 800.0 : UIScreen.main.bounds.height
        )


    } // varbody:someView:19
}

//struct DisplayOptionsView2_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayOptionsView2(showDisplayOptionsView: .constant(true))
//    }
//}
