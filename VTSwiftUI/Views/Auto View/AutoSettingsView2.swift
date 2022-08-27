//
//  SelectDrillSourceView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/20/22.
//

import SwiftUI


struct AutoSettingsView: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    
    @StateObject var model = SelectDrillSourceModel()
    @StateObject var verblistManagementModel = VerblistManagementModel()
    @StateObject var params = Params.shared
    
    @State var drillInterval: Double = Double(Params.shared.drillDuration)
    @State var answerInterval: Double = Double(Params.shared.answerDuration)
    @State var showSelectSingleVerbView: Bool = false
    @State var srchStr: String = ""
    
    @Binding var closeSwitch: Bool
    
    var maxDrill: Int32 = 30
    var minDrill: Int32 = 2
    
    var maxAnswer: Int32 = 30
    var minAnswer: Int32 = 2
    var verbGen = VerbGenerator.shared
    
    @EnvironmentObject var autoModel: AutoViewModel
    
    init(closeSwitch: Binding<Bool>) {
        self._closeSwitch = closeSwitch
        drillInterval = Double(Params.shared.drillDuration)
        answerInterval = Double(Params.shared.answerDuration)
        
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Spacer()
                        Text("Auto Settings")
                            .viewTitleStyle()
                            .padding(.top, 7)
                            .padding(.leading, 20)
                        Spacer()
                        Image(systemName: "chevron.down.circle")
                            .font(.system(size: 36))
                            .foregroundColor(Color.gray)
                            .padding(.top, 5)
                        //                        .padding(.trailing, -15)
                        //                        .border(Color.gray)
                            .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                            .onTapGesture {
                                closeSwitch = false
                            } // .onTap
                    }  // HStack:45
//                    .border(Color.red)
                    VStack {  // holds everything below the title/close button view
//                        Spacer()
//                        VStack {
                            VStack {  // holds the drill selection list
                                List {
                                    Section(header: Text("All Verbs")) {
                                        HStack {
                                            Text("Use All Verbs")
                                                .font(.system(size: textFontSize))
//                                                .frame(width: g.size.width * 0.8, alignment: .leading)
                                                .contentShape(Rectangle())
//                                                .border(Color.green)
                                            Spacer()
//                                            PrintFromView("environmentals.currentDisplayMode: \(environmentals.currentDisplayMode)")
                                            if environmentals.currentDisplayMode == .use_all_verbs {
                                                Image(systemName: "checkmark")
                                            }

                                        } // HStack:71
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
                                        } // HStack:93
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            showSelectSingleVerbView = true
                                        }
                                        HStack {
                                            if params.currentSelectedSingleVerbInfinitive == "" {
                                                Text("No infinitive selected")
                                                    .font(.system(size: textFontSize))
                                                
                                            } else {
//                                                PrintFromView("PFV - model.selectedInfinitive: \(model.selectedSingleVerb)")
                                                Text("Use \(model.selectedSingleVerb)")
//                                                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                                                    .font(.system(size: textFontSize))
                                                    .contentShape(Rectangle())
//                                                    .border(Color.green)
                                            }
                                            Spacer()
                                            if environmentals.currentDisplayMode == .use_one_verb {
                                                Image(systemName: "checkmark")
                                            }
                                        } // HStack:104
                                        .contentShape(Rectangle())

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
                                                } else { // List:144
                                                    Text("  ")
                                                        .frame(width: 40)
                                                }
                                            } // HStack:136
                                            .onTapGesture {
                                                //                            _ = PrintFromView("Tapped \(list.name)")
                                                model.selectedVerbList = list
                                                model.selectMode = .use_verb_list
                                                environmentals.currentDisplayMode = .use_verb_list
                                                environmentals.currentVerblist = list
                                            }
                                            
                                            
                                        } // ForEach:134

                                        
                                    }  // section
                                }  // List:69
                                
                                .onAppear {
                                    self.model.setup (environmentals)
                                }
                                .onDisappear {
                                    self.model.environmentals?.updateDrillSource()
                                    verbGen.getVerb()
                                }
                            }  // VStack:68  bottom of verb selection secion
//                            .border(Color.orange)
                            .frame(height:400)
//                            .fixedSize(horizontal: false, vertical: true)

//                            Spacer()
                            VStack {// holds both quiz interval setters
//                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Drill interval:")
                                        Text("\(Int(drillInterval)) seconds")
                                            .frame(width: 90)
                                            .fixedSize()
                                        Spacer()
                                    } // HStack:182
                                    .padding(.top, 25)
                                    .padding(.bottom, 10)
                                    HStack {
                                        Text("\(Int(minDrill)) sec.")
                                        Slider(value: $drillInterval, in: Double(minDrill)...Double(maxDrill)) { newValue in
                                            Log.print(drillInterval)
                                            if newValue == false {
                                                Log.print("New value is \(drillInterval)")
                                                autoModel.drillSeconds = Int32(drillInterval)
                                                Params.shared.drillDuration = Int32(drillInterval)
                                            }
                                        }
                                        Text("\(Int(maxDrill)) sec.")
                                    } // HStack:192
                                    .padding(.leading, 25)
                                    .padding(.trailing, 25)
                                    .padding(.top, -20)
                                    
                                } // VStack:181
//                                .border(Color.gray)
                                .frame(height:60)
                                VStack { // holds the answer interval setter
                                    HStack {
                                        Spacer()
                                        Text("Answer interval:")
                                        Text("\(Int(answerInterval)) seconds")
                                            .frame(width: 90)
                                            .fixedSize()
                                        Spacer()
                                    } // HStack:210
                                    .padding(.bottom, -5)
                                    
                                    HStack {
                                        Text("\(Int(minAnswer)) sec.")
                                        Slider(value: $answerInterval, in: Double(minAnswer)...Double(maxAnswer)) { newValue in
                                            Log.print(drillInterval)
                                            if newValue == false {
                                                Log.print("New value is \(answerInterval)")
                                                autoModel.answerSeconds = Int32(answerInterval)
                                                Params.shared.answerDuration = Int32(answerInterval)
                                            }
                                        }
                                        Text("\(Int(maxAnswer)) sec.")
                                    } // HStack:220
                                    .padding(.leading, 25)
                                    .padding(.trailing, 25)
                                    
                                    //            } // VStack:68
                                    //                                Spacer()
                                } // VStack:209
                                .frame(height:60)

//                                .border(Color.gray)
                            } // vstack
                        
//                            .border(Color.black)
                            .fixedSize(horizontal: false, vertical: true)

//                        } // VStack:67  drill selecion
                        .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 10 : 5)
//                        .border(Color.green)
                    } // HStack:64  everything below title bar view
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? geo.size.width * 0.75 : UIScreen.main.bounds.width * 0.80)
//                    .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? geo.size.height * 0.75 : UIScreen.main.bounds.height * 0.80)
//                    .border(Color.red)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    .padding(.bottom, 15)
                    .background(Color("BaseViewBackground"))
                    .onDisappear {
                        autoModel.invalidateTimers()
                        autoModel.newVerb()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BlueViewBorder"), lineWidth: 1)
                    )
                } // VStack:44
//                .border(Color.yellow)
            } // GeometryReader:43
        } // VStack:42
        
        .sheet(isPresented: $showSelectSingleVerbView) {
            //                SelectSingleVerbView(showSelectSingleVerbView: $showSelectSingleVerbView, selectedInfinitive: $selectedInfinitive, srchStr: $srchStr)
            SelectSingleVerbView(model: model, showSelectSingleVerbView: $showSelectSingleVerbView, srchStr: $srchStr)
        }  // .sheet:265
        
    } // varbody:someView:41
    
    
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
