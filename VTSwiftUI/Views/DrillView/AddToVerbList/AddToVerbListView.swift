//
//  AddToVerbListView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/24/22.
//

import SwiftUI

enum addRemoveVerbAction {
    case add
    case remove
}

struct AddToVerbListView: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @EnvironmentObject var verbGenerator: VerbGenerator
    
    @Binding var showAddRemoveView: Bool
    @State var showAlert: Bool = false
    
    var verblistManagementModel = VerblistManagementModel()
    
    @State var showConfirmationAlert: Bool = false
    @State var showToast: Bool = false
    
    var model = AddToVerbListModel()
    @State var pickedListName: String = ""
    
    var showBorders = false
    var body: some View {
        HStack {
            Spacer()
//            GeometryReader { g in
                HStack {
                    Spacer()
                    Image(systemName: "chevron.down.circle")
                        .font(.system(size: 36))
                        .foregroundColor(Color.gray)
                    //                .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 10 : -25)
                    //                .padding(.trailing, UIDevice.current.userInterfaceIdiom == .pad ? -60 : -20.0 )
                    //                    .padding(EdgeInsets(top:10, leading: 0, bottom: 15, trailing: 0))
                    //                        .border(Color.gray)
                        .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                        .onTapGesture {
                            showAddRemoveView = false
                        } // .onTap
                        .padding(.trailing, 20)
                    //                    .padding(.bottom, 10)
                } // hstack
//                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? g.size.width * 0.75 : UIScreen.main.bounds.width * 0.85)
                .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 35 : 10)
                .fixedSize()
                .border(showBorders ? Color.green : Color.clear)
                
//            } // geo
//            Spacer()

        }
        .frame(height:50)
        .border(showBorders ? Color.red : Color.clear)
        
        VStack {
            VStack {
                Text("Add '\(verbGenerator.displayVerb.infinitive)' to which verb list?")
                    .font(.system(size: 24))
                    .viewSmallTitleStyle()
                    .padding(.top, 10)
                GeometryReader { geo in
                    HStack {
                        Spacer()
                        VStack {
                            
                            ScrollView (.vertical, showsIndicators: true) {
                                ForEach(verblistManagementModel.verblists, id: \.name)   { list in
                                    HStack {
                                        Text(list.name)
                                            .contentShape(Rectangle())
                                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                                        //                                .border(Color.gray)
                                        Spacer()
                                        
                                    } // HStack:63
                                    
                                    .background(Color("ViewBackground"))
                                    .contentShape(Rectangle())
                                    .padding(.top, 1)
                                    .padding(.bottom, 1)
                                    .onTapGesture {
                                        //                    _ = PrintFromView("Tapped \(list.name)")
                                        let verblistModel = OneVerbListViewModel(vl: list)
                                        
                                        let idx = verblistManagementModel.verblists.firstIndex(where: { $0.name == list.name })
                                        if idx != nil {
                                            let selectedVerblist = verblistManagementModel.verblists[idx!]
                                            selectedVerblist.addVerb(verb: verbGenerator.displayVerb.infinitive)
                                            selectedVerblist.save()
                                            verblistModel.addInfinitive(inf: verbGenerator.displayVerb.infinitive)
                                            verblistManagementModel.verblists[idx!] = selectedVerblist
                                            pickedListName = selectedVerblist.name
                                        } // if
                                        
                                        showToast = true
                                        
                                    }
                                    
                                    
                                } // ForEach:62
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("ViewBorder"), lineWidth: 1)
                                )
                                
                            } // ScrollView:61
                            .border(showBorders ? Color.red : Color.clear)
                            
                            
                        } // VStack:56
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? geo.size.width * 0.65 : geo.size.width * 0.85)
                        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? geo.size.height * 0.80 : geo.size.height * 0.85)
                        .background(Color("BaseViewBackground"))
                        .border(showBorders ? Color.blue : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("ViewBorder"), lineWidth: 1)
                        )
                        
                        Spacer()
                    } // HStack:54
                    .border(showBorders ? Color.green : Color.clear)
                    //                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? geo.size.width * 0.65 : geo.size.width * 0.85)
                    
                    
                } // GeometryReader:53
            } // VStack:52

            .border(showBorders ? Color.yellow : Color.clear)
            .padding(.top, -20)
        } // VStack:30

        
        
        
        .onAppear {
            if verblistManagementModel.verblists.count == 0 {
                showAlert = true
            }
        }
        
        
        
        .toast(isPresenting: $showToast, duration: 1.5, tapToDismiss: true, alert: {
            AlertToast(type: .complete(Color.green), title: "\"\(verbGenerator.displayVerb.infinitive)\" \nadded to \"\(pickedListName)\".")
            //onTap would call either if `tapToDismis` is true/false
            //If tapToDismiss is true, onTap would call and then dismis the alert
        }, completion: {
            showAddRemoveView = false
        })
        //    } // vstack
        
        .alert(isPresented: $showAlert) { () -> Alert in
            let button = Alert.Button.default(Text("OK")) {
                print("OK Button Pressed")
                showAddRemoveView = false
            }
            return Alert(title: Text("No verb lists"), message: Text("You have not created any verb lists. Do that in the Settings -> Verb lists option"), dismissButton: button)
        }
        
    } // varbody:someView:29
} // structure

//struct AddToVerbListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToVerbListView(action: .constant(addRemoveVerbAction.add))
//    }
//}
