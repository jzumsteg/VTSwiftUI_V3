//
//  SelectDrillSourceView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/20/22.
//

import SwiftUI

var textFontSize = 14.0

struct SelectDrillSourceView: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    
    @StateObject var model = SelectDrillSourceModel()
    @StateObject var verblistManagementModel = VerblistManagementModel()
    @StateObject var params = Params.shared
    
    @State var showSelectSingleVerbView: Bool = false
    @State var srchStr = Params.shared.currentSearchStr
    
    @Binding var closeSwitch: Bool
    @State var showToast: Bool = true
    
    var verbGen: VerbGenerator = VerbGenerator.shared
    
    
    var body: some View {
        //        ZStack {
        VStack {
            HStack {

                Spacer()
                Image(systemName: "chevron.down.circle")
                    .font(.system(size: 36))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
                        closeSwitch = false
                    } // .onTap
            }  // HStack:29
        HStack {
            VStack {
//                Spacer()
                Text("Verb Selection for Drills")
                    .viewTitleStyle()
                    .padding(.top, 15)
                    .padding(.leading, 20)

                GeometryReader { geo in
                    List {
                        Section(header: Text("No Verb Filter")) {
                            HStack {
                                Text("Use All Verbs")
                                    .font(.system(size: textFontSize))
                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                    .contentShape(Rectangle())
                                //                            .border(Color.gray)
                                Spacer()
                                PrintFromView(environmentals.currentDisplayMode)
                                if environmentals.currentDisplayMode == .use_all_verbs {
                                    Image(systemName: "checkmark")
                                }
                                
                            } // HStack:49
                            .contentShape(Rectangle())
                            .onTapGesture {
                                environmentals.currentDisplayMode = .use_all_verbs
                                useAllVerbs()
                            }
                            
                            
                        }
                        Section(header: Text("Single verb")) {
                            HStack {
                                Text("Select single verb to use")
                                    .font(.system(size: textFontSize))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20.0))
                            } // HStack:71
                            .contentShape(Rectangle())
                            .onTapGesture {
                                showSelectSingleVerbView = true
                            }
                            HStack {
                                if params.currentSelectedSingleVerbInfinitive == "" {
                                    Text("No infinitive selected")
                                        .font(.system(size: textFontSize))
                                    
                                } else {
                                    PrintFromView("PFV - model.selectedInfinitive: \(model.selectedSingleVerb)")
                                    Text("Use \(model.selectedSingleVerb)")
                                        .frame(width: geo.size.width * 0.7, alignment: .leading)
                                        .font(.system(size: textFontSize))
                                        .contentShape(Rectangle())
                                }
                                Spacer()
                                if environmentals.currentDisplayMode == .use_one_verb {
                                    Image(systemName: "checkmark")
                                }
                            } // HStack:82
                            .onTapGesture {
                                if params.currentSelectedSingleVerbInfinitive == "" {
                                    environmentals.currentDisplayMode = .use_one_verb
                                }
                                else {
                                    useOneVerb()
                                    environmentals.currentDisplayMode = .use_one_verb
                                }
                                params.printYourself()
                            }
                            
                        }
                        Section(header: Text("Verb Lists")) {
                            ForEach(verblistManagementModel.verblists, id: \.name)   { list in
                                //                            PrintFromView("PFV - list: \(list.name)")
                                HStack {
                                    Text(list.name)
                                        .font(.system(size: textFontSize))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    //                                .frame(alignment: .topLeading)
                                        .contentShape(Rectangle())
                                    //                                .border(Color.gray)
                                    Spacer()
                                    if let val = model.selectedVerbList {
                                        if val.name == list.name && model.selectMode == .use_verb_list {
                                            Image(systemName: "checkmark")
                                                .frame(width: 40)
                                        }
                                    } else { // List:116
                                        Text("  ")
                                            .frame(width: 40)
                                    }
                                } // HStack:108
                                .onTapGesture {
                                    //                            _ = PrintFromView("Tapped \(list.name)")
                                    model.selectedVerbList = list
                                    model.selectMode = .use_verb_list
                                    environmentals.currentDisplayMode = .use_verb_list
                                    environmentals.currentVerblist = list
                                }
                                
                                
                            } // ForEach:106
                            
                        }  // section
                    }  // List:47

                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BlueViewBorder"), lineWidth: 1)
                    )

                    .onAppear {
                        self.model.setup (environmentals)
                        
                    }
                    .onDisappear {
                        self.model.environmentals?.updateDrillSource()
                        verbGen.getVerb()
                    }
                    
                    //
                    //            .frame(minWidth: 200.0, idealWidth: 300.0, maxWidth: .infinity, minHeight: 400.0, idealHeight:450.0, maxHeight: 700.0, alignment: .center)
                    
                }  // GeometryReader:46
                Spacer()
            } // vstack

//            .border(Color.red)
           
        }
        .toast(isPresenting: $showToast, duration: 2.0, tapToDismiss: true, alert: {
            AlertToast(displayMode: .banner(.pop), type: .regular, title: "Swipe down to dismiss.")
        }, completion: {
            Log.print("Dismissing")
        })
//        .border(Color.green)
        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 500 : UIScreen.main.bounds.width * 0.90)
//        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 500 : UIScreen.main.bounds.width * 0.90)

//        .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 25 : 10)
        }
        Spacer()
//        .border(Color.yellow)
        
        
//        Spacer()
            .sheet(isPresented: $showSelectSingleVerbView) {
                //                SelectSingleVerbView(showSelectSingleVerbView: $showSelectSingleVerbView, selectedInfinitive: $selectedInfinitive, srchStr: $srchStr)
                SelectSingleVerbView(model: model, showSelectSingleVerbView: $showSelectSingleVerbView, srchStr: $srchStr)
            }  // .sheet:150
        

    } // varbody:someView:27
    
    
    func useAllVerbs() {
        //        params.verbSelectMode = .use_all_verbs
        model.selectMode = .use_all_verbs
        //        environmentals.currentDisplay = .use_all_verbs
    }
    
    func useOneVerb() {
        //        params.verbSelectMode = .use_one_verb
        model.selectMode = .use_one_verb
        //        environmentals.currentDisplayMode = .use_one_verb
    }
}

//struct SelectDrillSourceView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectDrillSourceView()
//    }
//}
