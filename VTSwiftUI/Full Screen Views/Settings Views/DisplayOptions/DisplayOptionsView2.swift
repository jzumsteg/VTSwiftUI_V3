//
//  DisplayOptionsView2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/13/22.
//

import SwiftUI

struct DisplayOptionsView: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @StateObject var model: DisplayOptionsModel = DisplayOptionsModel()    
    
    @Binding var showDisplayOptionsView: Bool
    
    var textFontSize: CGFloat = 16

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

                        } // HStack:23
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

                        } // HStack:39
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

                        } // HStack:56
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
                        } // HStack:77
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
                        } // HStack:91
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
                        } // HStack:109
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
                        } // HStack:123
                        .contentShape(Rectangle())
                        .onTapGesture {
                            environmentals.currentInfinitiveDisplayMode = .english
                        }
                    } // section
                    
                } // List:21
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("ViewBorderGray"), lineWidth: 1)
                )
//                .border(Color.red)
                .frame(height: 500)
                .padding(.top, 50)
            }  // GeometryReader:20
//            .padding(.leading, 15)
//            .padding(.trailing, 15)
//            .onAppear {
//                self.model.setup ()
//            }
//            .navigationBarTitle("Display Options", displayMode: .automatic)
//            .navigationBarHidden(false)
//            .navigationBarBackButtonHidden(false)
//            .padding(.top, 50)
        }  // VStack:19

        .onAppear {
            self.model.setup ()
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .padding(.top, 50)


        .navigationBarTitle("Display Options", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
        .frame(
            width:UIScreen.main.bounds.width > 500 ? 500.0 : UIScreen.main.bounds.width,
            height:UIScreen.main.bounds.height > 800 ? 800.0 : UIScreen.main.bounds.height
        )


    } // varbody:someView:18
}

//struct DisplayOptionsView2_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayOptionsView2(showDisplayOptionsView: .constant(true))
//    }
//}
