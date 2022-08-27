//
//  TestSettingsView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/17/22.
//
//case timedSetVerbs = 0
//case timedNoSet = 1
//case untimed = 2

import SwiftUI
import Combine

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct TestSettingsView: View {
    @StateObject var model: TestSettingsViewModel = TestSettingsViewModel()
    
    @State var numVrbStr: String = ""
    @Environment(\.dismiss) private var dismiss

    @Binding var closeSwitch: Bool
    
    var textFontSize = CGFloat(14)
    var body: some View {
        VStack  {
            HStack {
                Spacer()
                
                Image(systemName: "chevron.down.circle")
                    .font(.system(size: 36))
                    .foregroundColor(Color.gray)
                    .padding(EdgeInsets(top:10, leading: 0, bottom: 15, trailing: 0))
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
//                        closeSwitch = false
                        dismiss()
                    } // .onTap
            }  // HStack:36
            .zIndex(1)
            .padding(.bottom, 15)
            .padding(.top, 10)
            
            VStack {
                GeometryReader { geo in
                    List {
                        Section(header: Text("Type of Test")) {
                            HStack {
                                Text("Set Time, Set Number of tests")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                if model.quizType == .timedSetVerbs {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:55
                            .contentShape(Rectangle())
                            .onTapGesture {
                                model.quizType = .timedSetVerbs
                            }
                            
                            
                            HStack {
                                Text("Set Time, No Set Number of tests")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                if model.quizType == .timedNoSet {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:73
                            .contentShape(Rectangle())
                            .onTapGesture {
                                model.quizType = .timedNoSet
                            }
                            
                            HStack {
                                Text("No Set Time, Set Number of tests")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                if model.quizType == .untimed {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:90
                            .contentShape(Rectangle())
                            .onTapGesture {
                                model.quizType = .untimed
                            }
                            
                            
                        }  // section
                        
                        Section(header: Text("Test Settings")) {
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Tests")
                                    TextField("Tests", text: $model.numVerbsStr)
                                        .keyboardType(.numberPad)
                                        .testSettingsInputStyle()
                                        .padding(.top, -20)
                                    
                                    
                                } // VStack:112
                                VStack {
                                    Text("Min:")
                                    TextField("Min", text: $model.numMinutesStr)
                                        .keyboardType(.numberPad)
                                        .testSettingsInputStyle()
                                        .padding(.top, -20)
                                    
                                } // VStack:121
                                VStack {
                                    Text("Sec")
                                    TextField("Sec", text: $model.numSecondsStr)
                                        .keyboardType(.numberPad)
                                        .testSettingsInputStyle()
                                        .padding(.top, -20)
                                    
                                } // VStack:129
                                Spacer()
                            } // HStack:111
                            
                        }  // section
                        
                        Section(header: Text("Other settings")) {
                            HStack {
                                Text("Show translation as a hint")
                                    .font(.system(size: textFontSize))
                                Spacer()
                                if model.translationHint {
                                    Image(systemName: "checkmark")
                                }
                            } // HStack:142
                            .contentShape(Rectangle())
                            .onTapGesture {
                                Log.print("Show translation")
                                model.translationHint.toggle()
                            }
//                            HStack {
//                                Text("Don't retest Correct Answers")
//                                    .font(.system(size: textFontSize))
//                                Spacer()
//                                if model.retestCorrect {
//                                    Image(systemName: "checkmark")
//
//                                }
//                            } // HStack:155
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                Log.print("Retest correct")
//                                model.retestCorrect.toggle()
//                            }
                        } // section
                        
                        .onAppear {
                            self.model.setup ()
                        }
                        
                        .onDisappear {
                            self.model.calcQuizDuration()
                        }
                        
                        
                    } // List:53

                } // GeometryReader:52

            } // VStack:51
            .frame(height:500)

            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BlueViewBorder"), lineWidth: 1)
            )
            Spacer()
        } // VStack:35
        .padding(.leading, 15)
        .padding(.trailing, 15)

    }  // varbody:someView:34
    


func changed(to value: String) {
    Log.print("changed to \(numVrbStr)")
    numVrbStr = numVrbStr.filter { $0.isNumber }
    Log.print("changed to \(numVrbStr)")
}
func callMe(with tx: String) {
    print("---> as you type \(tx)")
    let x = tx.filter { $0.isNumber }
    Log.print("\(x)")
    model.numVerbsStr = x
    numVrbStr = x
}
} // struct

struct TestSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TestSettingsView(closeSwitch: .constant(true))
    }
}
