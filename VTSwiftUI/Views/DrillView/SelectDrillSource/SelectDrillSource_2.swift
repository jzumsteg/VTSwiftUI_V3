//
//  SelectDrillSource_2.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/4/22.
//

import SwiftUI

struct SelectDrillSource: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @Binding var closeSwitch: Bool

    @StateObject var verblistManagementModel = VerblistManagementModel()
    @StateObject var params = Params.shared

    @State var showSelectView: Bool = false
    @State var srchStr = Params.shared.currentSearchStr
        @StateObject var model = SelectDrillSourceModel()

    var body: some View {
        Text("SelectDrillSource_2 View")
    } // varbody:someView:21
}

//struct SelectDrillSource_2_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectDrillSource_2()
//    }
//}
