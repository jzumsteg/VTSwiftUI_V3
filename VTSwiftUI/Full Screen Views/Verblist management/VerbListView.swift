//
//  VerbListView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/7/22.
//

import SwiftUI

struct VerbListView: View {
    @ObservedObject var verblistManagementModel = VerblistManagementModel()
    @ObservedObject var environmentalObjects: EnvironmentalObjects
    //    @ObservedObject var oneVerbListModel = OneVerbListViewModel()
    @State var showOneVerbListView: Bool = false
    @State var selectedVerbListName = String()
    
    var body: some View {
        var listname: String = self.selectedVerbListName
        GeometryReader { geo in
            HStack {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                VStack (spacing: 1) {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            selectedVerbListName = ""
                                            showOneVerbListView.toggle()
                                        }) {
                                            Image(systemName: "plus").font(.system(size: 24.0))
                                        }
                                    } // HStack:28
                                    .padding(.bottom, 10)
                                    
                                    List {
                                        ForEach(environmentalObjects.allVerbLists.verblists, id: \.name)   { list in
//                                            PrintFromView("PFV - list: \(list.name), \(environmentalObjects.redrawVerblists)")
                                            Text(list.name)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                                .contentShape(Rectangle())
                                            //                                .border(Color.gray)
                                                .onTapGesture {
                                                    selectedVerbListName = list.name
                                                    listname = list.name
                                                    Log.print("listname = \(listname)")
                                                    showOneVerbListView.toggle()
                                                }
                                            
                                        } // ForEach:40
                                        .onDelete(perform: deleteList)
                                        
                                    } // List:39
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("ViewBorderGray"), lineWidth: 1)
                                    )
                                    .onAppear(perform: {
                                        UITableView.appearance().contentInset.top = -25
                                    })
                                    .background(Color("BaseViewBackground"))
                                    
                                    Text("Click on a verb list to edit its infinitives list")
                                        .font(.system(size:14))
                                        .padding(.top, -25)
                                        .padding(.bottom, 10)
                                    
                                } // VStack:27

                                .frame(alignment: .leading)
                                //                .background(Color("BaseViewBackground"))
                                
                                Spacer()
                                
                            } // HStack:26
//                            .border(Color.red)
                        } // VStack:25
//                        .border(Color.green)

                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 600 : geo.size.width * 0.9)
//                        .frame(maxWidth: max(350, geo.size.width * 0.75))
                        
                        Spacer()
                        
//                            .background(Color.blue)
                    } // HStack:23
//                    .border(Color.blue)
                    Spacer()
                } // VStack:22
//                .border(Color.yellow)
//
                
                .sheet(isPresented: $showOneVerbListView) {
//                    PrintFromView("selectedVerbListName = \(selectedVerbListName)")
                    OneVerbListView(vlName: listname, showVerbListView: $showOneVerbListView)
                        .environmentObject(verblistManagementModel)
                        .environmentObject(environmentalObjects)
                } // .sheet:87
                
            } // HStack:20

            //            .frame(width: min(600, geo.size.width * 0.85))
//            .background(Color.gray).opacity(0.2)
            .navigationBarTitle("Verb List Options", displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
//                    .background(Color("BaseViewBackground"))
//            .padding(.leading, 20)
//            .padding(.trailing, 20)
            //            .padding(.top, -50)
            .padding(.bottom, 25)
        } // GeometryReader:19
    } // varbody:someView:17
    
    func deleteList(at indexSet: IndexSet) {
        //        self.animals.remove(atOffsets: indexSet)
        Log.print("delete offset \(indexSet)")
        for _ in indexSet{
            environmentalObjects.allVerbLists.deleteVerblist(atOffset:  indexSet)
            //            environmentalObjects.allVerbLists.populateVerblists()
            environmentalObjects.redrawVerblists.toggle()
        }
    }
    
} // varbody:someView:16
//
//struct VerbListView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerbListView(verblistManagementModel: VerblistManagementModel())
//            .environment(verblistManagementModel)
//    }
//}
