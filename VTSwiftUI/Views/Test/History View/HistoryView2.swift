//
//  HistoryView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/18/22.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var model = HistoryViewModel()
    @Binding var closeSwitch: Bool
    
    var rowData = ["test"]
    let colWidths = [0.50, 0.25, 0.25]
    let numCols = 3
    let numCells: Int = 0
    let tableMaxWidth = 300.0
    let tableMinWidth = 300.0
    
    //        init() {
    //            let historyList: [String] = model.historyList
    //        }
    
    var gridItemLayout = [GridItem(.fixed(175)), GridItem(.fixed(75)), GridItem(.fixed(50))]
    
    
    var body: some View {
        ZStack (alignment: .top) {
            HStack {
                Spacer()

            Image(systemName: "chevron.down.circle")
                .font(.system(size: 32))
                .foregroundColor(Color.gray)
                .zIndex(2)
                .padding(.top, 10)
                .padding(.trailing, 10)
            //                        .border(Color.gray)
                .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                .onTapGesture {
                    closeSwitch = false
                } // .onTap
            } // HStack:30
            Text("Quiz History")
                .font(.system(size: 28))
                .padding(.top, 10)
            if model.cellCount > 0 {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 10) {
                        ForEach((0...model.cellCount-1), id: \.self) { idx in
                            Text("\(model.historyList[idx])")
                                .font(.system(size: 14))
                            //                        .frame(width: 100, height: 25)
                                .cornerRadius(10)
                            //                        .border(Color.gray)
                        } // ForEach:50
                    }
                    
                    .padding(.trailing, 20)
                    //            .padding(.leading, 20)
                } // ScrollView:48
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BlueViewBorder"), lineWidth: 1)
                )
//                .cornerRadius(10)
//                .background(Color("AnswerFieldBackground"))
//                .border(Color.gray)
                .frame(width: 350)
                .padding(.top, 50)
                .padding(.bottom, 75)

                .zIndex(0)
            }
            

            
            VStack {
                Spacer()
                Button(action: {
                    model.clearHistory()
                }
                ) {
                    Text("Clear History")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    
                }
                .buttonStyle(RoundedRectangleButtonStyle())
                .frame(maxWidth: 300.0, maxHeight: 40.0)
                .padding(.bottom, 25)
                .zIndex(1)
                .onAppear {
                    model.setup()
                }
            } // VStack:74
            
        } // ZStack:29


        
    } // varbody:someView:28
}
//
//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView(showHistoryView: .constant(true))
//    }
//}
