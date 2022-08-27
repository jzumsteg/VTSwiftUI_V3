//
//  TenseSelectionRow.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/22/21.
//

import SwiftUI

struct TenseSelectionRow: View {
    @Binding var rowState: SelectionRowModel
//    @Binding var tenseState: Bool
    var settings = AllVerbSettingsGroup()

    var body: some View {
        Toggle(rowState.settingName, isOn: $rowState.settingState.didSet {(state) in
            print("New value is: \(state)")
            _ = settings.setState(setting_name: rowState.settingName, state: state)
        })
    } // varbody:someView:15
}

//struct TenseSelectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TenseSelectionRow()
//    }
//}
