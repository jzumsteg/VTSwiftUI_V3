//
//  AddToVerbListView2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 4/2/22.
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
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "chevron.down.circle")
                    .font(.system(size: 36))
                    .foregroundColor(Color.gray)
                    .padding(EdgeInsets(top:10, leading: 0, bottom: 15, trailing: 0))
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
                        showAddRemoveView = false
                    } // .onTap
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
            } // HStack:31
            Text("Add 'verbGenerator.displayVerb.infinitive' to which verb list?")
                .font(.system(size: 24))
                .viewSmallTitleStyle()
                .padding(.top, 20)
            ScrollView {
                
            }
            Spacer()
        }
        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.width * 0.55 : UIScreen.main.bounds.width * 0.85)
        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.height * 0.75 : UIScreen.main.bounds.height * 0.80)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("ViewBorder"), lineWidth: 1)
        )
    }
}

struct AddToVerbListView2_Previews: PreviewProvider {
    static var previews: some View {
        AddToVerbListView(showAddRemoveView: .constant(true))
    }
}
