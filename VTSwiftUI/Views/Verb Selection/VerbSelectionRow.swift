//
//  FilterRow.swift
//  Wordtrainer
//
//  Created by John Zumsteg on 10/25/21.
//

import SwiftUI

struct VerbSelectionRow: View {
    @Binding var filterName: String
    var body: some View {
   
        HStack {
            Text("\($filterName.wrappedValue)")
                    .onTapGesture {
                        self.tapped(filterName:$filterName.wrappedValue)
                    }
                   .frame(width: 280, alignment: .leading)
       
            if true {
                Image("checkmark")
            }
            Spacer()
        } // HStack:14
        .background(Color("viewBackground"))
    } // varbody:someView:12

    func tapped(filterName: String) {
            Log.print("tapped \(filterName)")
        }

}
