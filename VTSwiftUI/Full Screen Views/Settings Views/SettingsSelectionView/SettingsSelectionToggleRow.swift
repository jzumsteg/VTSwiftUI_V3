//
//  SettingsSelectionToggleRow.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 12/2/21.
//

import SwiftUI

struct SettingsSelectionToggleRow: View {
    @ObservedObject var settings: Selection
    @StateObject var verbState: VerbState
    @ObservedObject var model: SettingsSelectionModel

    var body: some View {
        HStack {
            Text("\(verbState.name)")
            Spacer()
            if verbState.verbState == true {
                Image("checkmark")
            }
        } // HStack:15
        .contentShape(Rectangle())
        .onTapGesture {
            verbState.verbState.toggle()
            settings.setAValue(name: verbState.name, value: verbState.verbState)
            Log.print("\(verbState.name).state = \(verbState.verbState)")
            _ = model.getVerbCount()
        }

    } // varbody:someView:14
}

//struct SettingsSelectionToggleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsSelectionToggleRow()
//    }
//}
