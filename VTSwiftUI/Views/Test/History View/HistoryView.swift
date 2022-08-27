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
    
    var historyList = [String]()
    
    //    init() {
    //    }
    
    var body: some View {
        GeometryReader { geo in
        ZStack (alignment: .topTrailing) {
            Image(systemName: "multiply.circle")
                .font(.system(size: 32))
                .foregroundColor(Color.gray)
                .padding(.top, 10)
                .padding(.trailing, -5)
            //                        .border(Color.gray)
                .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                .onTapGesture {
                    closeSwitch = false
                } // .onTap
        VStack {
            VStack {
                Text("HistoryView")
                    .viewTitleStyle()
                    .padding(.top, 25)
                    .padding(.bottom, 25)
                    .onAppear {
                        model.setup()
                    }
                HStack {
                    Text("Date/Time")
                        .frame(width: 125)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 13, design: .monospaced))
//                        .border(Color.gray)
                    Text("Tests")
                        .frame(width: 42)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 13, design: .monospaced))
//                        .border(Color.gray)
//                    Text("Right")
//                        .frame(width: 42)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .font(.system(size: 13, design: .monospaced))
//                    Text("Wrong")
//                        .frame(width: 42)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .font(.system(size: 13, design: .monospaced))
                    Spacer()
                    Text("Pct Right")
                        
                        .frame(width: 50)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 13, design: .monospaced))
                        .padding(.trailing, 15)
//                        .border(Color.gray)
                } // HStack:41
                .frame(width: min(400, geo.size.width * 0.95))
                
                ForEach(model.historyList, id: \.self)   { list in
                    Text(list)
                        .font(.system(size: 13, design: .monospaced))
                        .frame(width: min(400, geo.size.width * 0.95))
                        .frame(alignment: .leading)
                        .padding(.top, 4)
                        .padding(.bottom, 3)
                    
                } // ForEach:71


//                .border(Color.red)
            } // VStack:33
            Spacer()
            Button(action: {
                model.clearHistory()
            }
            ) {
                Text("Clear History")
                    .font(.system(size: 16, weight: .bold, design: .rounded))

            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .frame(maxWidth: 200.0, maxHeight: 40.0)

        } // VStack:32
//        .border(Color.gray)
        .padding(.bottom, 50)
    } // ZStack:21
        .frame(width: max(350, geo.size.width * 0.95))
        .fixedSize(horizontal: true, vertical: false)
        } // GeometryReader:20
        
    } // varbody:someView:19
}
//
//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView(showHistoryView: .constant(true))
//    }
//}
