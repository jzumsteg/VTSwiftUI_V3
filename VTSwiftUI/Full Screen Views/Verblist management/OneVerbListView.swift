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
    
    @State var invalidVerbList: Bool = false
    
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
                Image(systemName: "chevron.down.circle")
                    .font(.system(size: 36))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
                        model.verblist.name = model.verblist.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        if model.verblist.isDirty == true {
                            saveChangesAlert = true
                        }
                        else {
                            dismiss()
                        }
                    } // .onTap
            } // HStack:47



            .alert(isPresented: $saveChangesAlert) {
                Alert(title: Text("Save changes"),
                      message: Text("You have made changes to this verb list. Do you want to save them?"),
                      primaryButton: .destructive(Text("No, discard changes"), action: {
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
                TextField("Enter verb list name", text: $model.verblist.name, onEditingChanged: { isEditing in
//                    if model.verbListName != model.originalVerbList.name {
//                        model.verblist.isDirty = true
//                        Log.print("model.verbListName: \(model.verbListName), model.originalVerbList.name:\(model.originalVerbList.name)")
//                    }
                })
                    .onChange(of: model.verblist.name) { newValue in
                        print("Name changed to \($model.verblist.name)!")
                        if model.verblist.name.trimmingCharacters(in: .whitespacesAndNewlines) != model.originalVerbList.name.trimmingCharacters(in: .whitespacesAndNewlines) {
                            model.verblist.isDirty = true
                        }
                    }
                    .modifier(TextFieldClearButton(text: $model.verblist.name))
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 15)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
                Button(action: {
                    model.verblist.name = model.verblist.name.trimmingCharacters(in: .whitespacesAndNewlines)
                    if model.isValidForSave() == false {
                        invalidVerbList = true
                    }
                    if model.verblist.isDirty {
                        if model.isNameChanged() == true { // the name changed, see if it is unique
                            if model.isNameUnique() == true {
                                model.saveVerblist()
                            }
                            else { // the name is not unique, raise the alert
                                saveProblemAlert = true
                            }
                        }
                        else { // then name didn't change, save it
                            model.saveVerblist()
                        }
                    }
                    
                    
                    
                    
                }) {
                    Text("Save Changes")
                }
                .alert(isPresented: $saveProblemAlert) {
                    Alert(title: Text("Save Problem"),
                          message: Text("A verb list already exists with this name. What do you want to do?"),
                          primaryButton: .destructive(Text("Overwrite the existing list"), action: {
                        Log.print("Overwrite")
                        model.saveVerblist()
                        
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
            } // HStack:85
            
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
                                } // ForEach:134
                                .onDelete(perform: deleteInf)
                            } // List:133
                            .frame(width: geometry.size.width * 0.4)
                            
                            .onAppear(perform: {
                                UITableView.appearance().contentInset.top = -25
                            })
                        } // VStack:130
                        
                        VStack {
                            TextField("Enter search text here", text: $srchStr)
                                .onChange(of:srchStr) { newValue in
                                    Log.print("schrStr: \(srchStr), newValue: \(newValue)!")
                                    model.getFilterdInfinitives(searchStr: newValue.lowercased())
                                }
                                .textFieldStyle(.roundedBorder)
                                .padding(.trailing, 15)
                                .autocapitalization(.none)
                            
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
                                    
                                } // HStack:157
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
                                model.infType = infType
                                model.getAllInfinitives()
                                
                            }) {
                                Text("Toggle Infinitives")
                            }
                            .buttonStyle(RoundedRectangleButtonStyle())
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        } // VStack:147
                        .padding(.bottom, 10)
                        .frame(width: geometry.size.width * 0.6)
                        
                        Spacer()
                    } // HStack:129
                } // VStack:128
                .alert(isPresented: $invalidVerbList) { () -> Alert in
                            let button = Alert.Button.default(Text("OK")) {
                                invalidVerbList = false
                            }
                            return Alert(title: Text("Invalid Verb List"), message: Text("A verb list requires a name and at least one infinitive."), dismissButton: button)
                        }
                
            } // GeometryReader:127
            //            Button(action: {
            //                print("trying to close")
            //                if obsModel.verblist.isDirty == true {
            //                    saveChangesAlert = true
            //                }
            //                else {
            //                    showVerbListView = false
            //                }
            //
            //            }) {
            //                Text("Close")
            //            }
            //            .padding(.leading, 50)
            //            .padding(.trailing, 50)
            //            .buttonStyle(RoundedRectangleButtonStyle())
            
            
        }  // VStack:46
        //        .background(Color.gray)
        //        .opacity(0.2)
        //        .frame(width: horizontalSizeClass = )
        .interactiveDismissDisabled()
        .onAppear {
            Log.print("vstack appeared!")
            model.setup(verbListName: verbListName, environmentObjects: environmentObjects)
            
            model.verblist.isDirty = false
            
        }
        
        
        
        
    } // varbody:someView:45
    func deleteInf(at indexSet: IndexSet) {
        //        self.animals.remove(atOffsets: indexSet)
        Log.print("delete offset \(indexSet)")
        model.deleteInfinitive(atOffset: indexSet)
    }
    
    func saveVerbList() {
        model.verblist.isDirty = false
        model.verblist.save()
        environmentObjects.allVerbLists.verblists.append(model.verblist)
        environmentObjects.allVerbLists.verblists.sort {$0.name < $1.name}
        environmentObjects.redrawVerblists = true
    }
    
    //    func saveVerblist() {
    //        Log.print("Save verblist \(obsModel.verblist.name)")
    //        obsModel.verblist.printYourself()
    //        if obsModel.verblist.name == "" || obsModel.verblist.infinitives.count == 0 {
    //            Log.print("Cannot save this verblist \(obsModel.verblist.name)")
    //        } else {
    //            Log.print("Saving the verblist \(obsModel.verblist.name)")
    //            if obsModel.verblist.isNew == true {
    //                verbListModel.verblists.append(obsModel.verblist)
    //            }
    //            obsModel.verblist.save()
    //        }
    //    }
}

//
//struct OneVerbListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OneVerbListView(verbListName:Binding<"List 1">)
//    }
//}
