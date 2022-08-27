//
//  SelectSingleVerbView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/22/22.
//

import SwiftUI

struct SelectSingleVerbView: View {
    @ObservedObject var model: SelectDrillSourceModel
    @Binding var showSelectSingleVerbView: Bool
//    @Binding var selectedInfinitive: String
    
    @Binding var srchStr: String
    
    var listTextSize = 18.0
    @ObservedObject var obsModel = SelectSingleVerbViewModel()
//    @ObservedObject var paramModel = Params.shared
    @State var infType: Infinitive_list_display = .language
    @State var searchStr: String = ""
    @State var infinitivesList = [String]()

    var body: some View {
        GeometryReader {geo in
            VStack {
                HStack {
                    Text("Select Single Verb")
                        .viewTitleStyle()
                        .padding(.leading, 20)
                    Spacer()
                    Image(systemName: "chevron.down.circle")
                        .font(.system(size: 36))
                        .foregroundColor(Color.gray)
                        .padding(.top, 5)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                    //                        .border(Color.gray)
                        .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                        .onTapGesture {
                            showSelectSingleVerbView = false
                        } // .onTap
                }  // HStack:27
                
                VStack {
                    TextField("Enter search text here", text: $srchStr)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of:srchStr) { newValue in
                            Log.print("schrStr: \(srchStr), newValue: \(newValue)!")
                            obsModel.searchStr = srchStr
                            obsModel.getFilterdInfinitives(searchStr: newValue.lowercased())
                            searchStr = srchStr
                            Params.shared.currentSearchStr = searchStr
                            
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding(.trailing, 15)
                    
                    List(obsModel.allInfinitives, id: \.self) { infinitive in
                        HStack {
                            Text("\(infinitive)").modifier(ListRowModifier())
                                .font(.system(size: listTextSize))
//                                .border(Color.gray)
//                                .onTapGesture {
//                                    model.selectedSingleVerb = Infinitives.theInfinitive(textStr: infinitive, language: infType)
////                                    PrintFromView("PFV - model.selectedSingleVerb: \(model.selectedSingleVerb)")
//                                }
//                                .contentShape(Rectangle())

                            Spacer()
                            if model.selectedSingleVerb == Infinitives.theInfinitive(textStr: infinitive, language: infType) {
                                Image(systemName: "checkmark")
                            } else {
                                Text("  ")
                            }
                            
                        } // HStack:60
                        .contentShape(Rectangle())
                        .onTapGesture {
                            model.selectedSingleVerb = Infinitives.theInfinitive(textStr: infinitive, language: infType)
//                                    PrintFromView("PFV - model.selectedSingleVerb: \(model.selectedSingleVerb)")
                        }
                        
                        
                        
                    }
                    .onAppear(perform: {
                        UITableView.appearance().contentInset.top = -25
                    })
                    //                    .padding(.top, -20)
                    Button(action: {
                        if infType == .language {
                            infType = .english
                        } else {
                            infType = .language
                        }
                        srchStr = ""
                        obsModel.infType = infType
                        obsModel.getAllInfinitives()
                        
                    }) {
                        Text("Toggle Infinitives")
                    }
                    .frame(width: geo.size.width * 0.8)
                    .buttonStyle(RoundedRectangleButtonStyle())
                } // VStack:45
                .contentShape(Rectangle())
                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.85, alignment: .center)
//                .border(Color.gray)
                
            } // VStack:26
            
        } // GeometryReader:25
        
    } // varbody:someView:24
    
}

//struct SelectSingleVerbView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectSingleVerbView()
//    }
//}
