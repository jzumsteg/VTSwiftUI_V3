//
//  OneVerbListView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/11/22.
//

import SwiftUI




struct OneVerbListView: View {
    @StateObject var model: OneVerbListViewModel = OneVerbListViewModel()
    @EnvironmentObject var environmentObjects: EnvironmentalObjects
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dismiss) private var dismiss
    
//    @Binding var showVerbListView: Bool
    var verbListName: String
    
    @State var infListType: Infinitive_list_display = .language
    @State var srchStr = ""
    
    @State var infType: Infinitive_list_display = .language
    
    @State var saveChangesAlert = false
    @State var saveProblemAlert = false
    @State var showToast: Bool = false
    @State var redraw: Bool = false
    
    //    var model = OneVerbListViewModel()
    var originalVerbList = [String]()
    var listTextSize = 14.0
    
    
    init (vlName: String, showVerbListView: Binding<Bool>) {
//        self._showVerbListView = showVerbListView
        verbListName = vlName
        
        
    }
    var body: some View {
        VStack {
            HStack {
                Text("Add/Remove Infinitives")
                    .viewTitleStyle()
                    .padding(.leading, 20)
                    .padding(.top, 10)
                Spacer()
                Image(systemName: "multiply.circle")
                    .font(.system(size: 32))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
                        if model.verblist.isDirty == true {
                            saveChangesAlert = true
                        }
                        else {
                            dismiss()
                        }
                    } // .onTap
            } // HStack:46
            .alert(isPresented: $saveChangesAlert) {
                Alert(title: Text("Save changes"),
                      message: Text("You have made changes to this verb list. Do you want to save them?"),
                      primaryButton: .destructive(Text("No, discard changes"), action: {
                    Log.print("Discard")
                    model.revertToOriginal()
                    saveChangesAlert = false
                    dismiss()
                    
                }),
                      secondaryButton: .cancel(Text("Return to verb list"), action: {
                    Log.print("Cancel")
                })
                )
            }
            
            HStack { // textfield and save button
                TextField("Enter verb list name", text: $model.verblist.name)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    if model.verblist.isNew == false {
                        if environmentObjects.allVerbLists.verbListExists(vlName: model.verblist.name) == false {
                            saveVerbList()
                        }
                        else { // it's new, but the name exist}
                            saveProblemAlert = true
                        }
                    }
                    else { // it's not new
                        if model.isNameNew() == true { // user changed the name
                            if environmentObjects.allVerbLists.verbListExists(vlName: model.verblist.name) == true {
                                saveProblemAlert = true
                                
                            }
                            else {  // changed the name, but verblist  with new name does not exist
                                saveVerbList()
                            }
                            
                        }
                    }
                    
                    
                    
                    
                    
                }) { // HStack:84
                    Text("Save Changes")
                }
                .alert(isPresented: $saveProblemAlert) {
                    Alert(title: Text("Save Problem"),
                          message: Text("A verb list already exists with this name. What do you want to do?"),
                          primaryButton: .destructive(Text("Overwrite the existing list"), action: {
                        Log.print("Overwrite")
                        model.verblist.save()
                        
                        //                saveProblemAlert = false
                        //                showVerbListView = false
                        
                    }),
                          secondaryButton: .cancel(Text("Return to verb list"), action: {
                        Log.print("Cancel")
                        saveProblemAlert = false
                    })
                    )
                }
                .buttonStyle(RoundedRectangleButtonStyle())
            } // VStack:45
            
            .padding(.top, 15)
            .padding(.bottom, 20)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            GeometryReader { geometry in
                VStack {
                    HStack {
                        VStack {
                            Text("Verbs in list")
                                .padding(.top, 10)
                            List {
                                ForEach(model.verblist.infinitives, id: \.self) { infinitive in
                                    Text("\(infinitive)")
                                        .font(.system(size: listTextSize))
                                } // ForEach:148
                                .onDelete(perform: deleteInf)
                            } // List:147
                            .frame(width: geometry.size.width * 0.4)
                            
                            .onAppear(perform: {
                                UITableView.appearance().contentInset.top = -25
                            })
                        } // VStack:144
                        
                        VStack {
                            TextField("Enter search text here", text: $srchStr)
                                .onChange(of:srchStr) { newValue in
                                    Log.print("schrStr: \(srchStr), newValue: \(newValue)!")
                                    model.getFilterdInfinitives(searchStr: newValue.lowercased())
                                }
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing, 15)
                            
                            List(model.allInfinitives, id: \.self) { infinitive in
                                HStack {
                                    Text("\(infinitive)")
                                        .font(.system(size: listTextSize))
                                    
                                    Spacer()
                                    if model.verblist.infinitives.contains(Infinitives.theInfinitive(textStr: infinitive, language: infType)) {
                                        Image(systemName: "checkmark")
                                    } else {
                                        Text("  ")
                                    }
                                    
                                } // HStack:171
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    Log.print("tapped")
                                    showToast = true
                                    model.verblist.isDirty = true
                                    if model.verblist.infinitives.contains(infinitive) {
                                        model.removeInfinitive(inf: infinitive)
                                    } else {
                                        model.addInfinitive(inf: infinitive)
                                    }
