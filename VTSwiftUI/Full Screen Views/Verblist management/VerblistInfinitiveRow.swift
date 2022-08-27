//
//  VerblistInfinitiveRow.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/8/22.
//

import SwiftUI

struct VerblistInfinitiveRow: View {
//    @ObservedObject var settings: Selection
//    @StateObject var verbState: VerbState
    @Binding var selected: Bool
    var infinitive: String


    var body: some View {
        HStack {
            Text("\(infinitive)")
            Spacer()
            if $selected.wrappedValue == true {
                Image("checkmark")
            }
        } // HStack:18
        .contentShape(Rectangle())
        .onTapGesture {
            selected.toggle()
        }

    } // varbody:someView:17
}

struct VerblistInfinitiveRow_Previews: PreviewProvider {
    static var previews: some View {
        VerblistInfinitiveRow(selected: .constant(true), infinitive: "infinitive")
    }
}
