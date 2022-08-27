//
//  HTMLView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/25/22.
//

import SwiftUI

struct HTMLView: View {
    var htmlFileName: String
    var whichView: web_views
    @State var htmlStr: String = ""
    @StateObject var model: HTMLViewModel = HTMLViewModel()
    
//    init() {
//        do {
//            try htmlStr = String(contentsOfFile: htmlFileName)
//        } catch let error as NSError {
//            Log.print(error.description)
//            htmlStr = ""
//        }
//    }
    
    var body: some View {
            VStack (alignment: .center){
                HTMLStringView(htmlContent: model.getHTMLString(whichView: whichView))
            } // VStack:27
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color("ViewBorderGray"), lineWidth: 1)
            )
            .frame(
                maxWidth: UIScreen.main.bounds.width < 320 ? 320 : UIScreen.main.bounds.width * 0.9
//                height:UIScreen.main.bounds.height > 800 ? 800.0 : UIScreen.main.bounds.height
            )
//            .padding(.leading, (geo.size.width - geo.size.width * 0.85)/2)
        .navigationBarTitle("", displayMode: .inline)

    } // varbody:someView:25
}
//struct HTMLView_Previews: PreviewProvider {
//    static var previews: some View {
//        HTMLView()
//    }
//}

