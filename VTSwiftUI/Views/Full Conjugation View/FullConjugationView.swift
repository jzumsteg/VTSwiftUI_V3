//
//  FullConjugationView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/14/22.
//

import SwiftUI

struct FullConjugationView: View {
    @State var inf: String
    @Binding var closeSwitch: Bool
    var model = FullConjugationViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Conjugation View for '\(inf)'")
                    .viewTitleStyle()
                    .padding(.top, 15)
                    .padding(.leading, 25)
                Spacer()
                Image(systemName: "chevron.down.circle")
                    .font(.system(size: 36))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                //                        .border(Color.gray)
                    .frame(width: 40.0, height: 40.0, alignment: .topTrailing)
                    .onTapGesture {
                        closeSwitch = false
                    } // .onTap
            } // HStack:19
            HTMLStringView(htmlContent: Utilities.getVerbParts(inf: inf))
                .frame(height: 105)
                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 600.0 : UIScreen.main.bounds.width * 0.95)
//                .border(Color.green)
//            HTMLStringView(htmlContent: Utilities.getConjugationHTML(inf: inf))
            HTMLStringView(htmlContent: model.retrieveConjugation(infinitive: inf))

                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 600.0 : UIScreen.main.bounds.width * 0.95)
//                .border(Color.red)
            
        } // VStack:18
//        .border(Color.red)
    } // varbody:someView:17
}

//struct FullConjugationView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullConjugationView(closeSwitch: .constant(true))
//    }
//}
