//
//  HistoryRow.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/19/22.
//

import SwiftUI

struct HistoryRow: View {
    var rowData = ["Col 1", "Col 2", "Col3"]
    let colWidths = [50.0, 25.0, 25.0]
    let numCols = 3
    let tableMaxWidth = 300.0
    let tableMinWidth = 300.0
    var body: some View {
        VStack {
        GeometryReader { g in
//            PrintFromView("\(g.size.width), \(g.size.height)")
            HStack {
                Text(rowData[0])
                    .frame(width: min(tableMaxWidth * colWidths[0], g.size.width * 0.5))
                    .fixedSize(horizontal: true, vertical: false)
//                    .border(Color.red)
                Text(rowData[1])
                    .frame(width: min(tableMaxWidth * colWidths[1], g.size.width * 0.25))
                    .fixedSize(horizontal: true, vertical: false)
//                    .border(Color.red)
                Text(rowData[2])
                    .frame(width: min(tableMaxWidth * colWidths[2], g.size.width * 0.25))
                    .fixedSize(horizontal: true, vertical: false)
//                    .border(Color.red)
                
            } // HStack:20
            .frame(width: 375.0)
            .fixedSize()
        } // GeometryReader:18
        } // VStack:17
        .border(Color.green)
    } // varbody:someView:16
}

//struct HistoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryRow()
//    }
//}
