//
//  TableTest.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 3/2/22.
//

import SwiftUI

var rowData = ["Col 1", "Col 2", "Col3"]
let colWidths = [0.50, 0.25, 0.25]
let numCols = 3
let tableMaxWidth = 300.0
let tableMinWidth = 300.0
var body: some View {
    VStack {
        GeometryReader { g in
            GeometryReader {g1 in
                HStack {
                    Text(rowData[0])
                        .frame(width: (g1.frame(in: .local).maxX - g1.frame(in: .local).minX) * colWidths[0])
                        .fixedSize(horizontal: true, vertical: false)
                        .border(Color.red)
                    Text(rowData[1])
                        .frame(width: (g1.frame(in: .local).maxX - g1.frame(in: .local).minX) * colWidths[1])

                        .fixedSize(horizontal: true, vertical: false)
                        .border(Color.red)
                    Text(rowData[2])
                        .frame(width: (g1.frame(in: .local).maxX - g1.frame(in: .local).minX) * colWidths[2])

                        .fixedSize(horizontal: true, vertical: false)
                        .border(Color.red)
                } // HStack:19
                .frame(width: 300.0)
                .fixedSize()
                .border(Color.yellow)
            } // GeometryReader:18
            
        } // GeometryReader:17
    } // VStack:16
    .background(Color.gray)
    
} // varbody:someView:15


