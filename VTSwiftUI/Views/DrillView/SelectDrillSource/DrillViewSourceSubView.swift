//
//  DrillViewSourceSubView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 3/26/22.
//

import SwiftUI

struct DrillViewSourceSubView: View {
    @EnvironmentObject var environmentals:EnvironmentalObjects

    var body: some View {
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
            .onAppear {
                self.model.setup (environmentals)
            }
            .onDisappear {
                self.model.environmentals?.updateDrillSource()
                verbGen.getVerb()
            }
            
            .frame(minWidth: 200.0, idealWidth: 300.0, maxWidth: .infinity, minHeight: 400.0, idealHeight:450.0, maxHeight: 800.0, alignment: .center)
            
        }
    }
}

struct DrillViewSourceSubView_Previews: PreviewProvider {
    static var previews: some View {
        DrillViewSourceSubView()
    }
}
