//
//  TenseLocaleView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 3/14/22.
//

import SwiftUI

struct TenseLocaleView: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @StateObject var model = TenseLocaleViewModel()
    
    @Binding var showTenseLocaleView: Bool
    
    var body: some View {
        VStack (alignment: .leading) {
            List {
                Section(header: Text("Select locale for tense names")) {
                    HStack {
                        Text("Castilian Spanish")
                        //                    .frame(width: geo.size.width * 0.7, alignment: .leading)
                            .font(.system(size: textFontSize))
                            .contentShape(Rectangle())
                        
                        Spacer()
                        if environmentals.tenseLocale == .default_locale {
                            Image(systemName: "checkmark")
                        }
                    } // HStack:124
                    .contentShape(Rectangle())
                    .onTapGesture {
                        environmentals.tenseLocale = .default_locale
                    }
                    HStack {
                        Text("South American")
                        //                .frame(width: geo.size.width * 0.7, alignment: .leading)
                            .font(.system(size: textFontSize))
                            .contentShape(Rectangle())
                        
                        Spacer()
                        if environmentals.tenseLocale == .alternative_locale_1 {
                            Image(systemName: "checkmark")
                        }
                    } // hstack
                    .onTapGesture {
                        environmentals.tenseLocale = .alternative_locale_1
                    }
                }
                } // VStack
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BlueViewBorder"), lineWidth: 1)
            )
                .frame(width: 300)
                .frame(height: 200)
                .padding(.top, 5)
                .fixedSize()
            
            Spacer()
            }
        .padding(.top, 50)

        .navigationBarTitle("Tense Names Options", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)

    }
}


//struct TenseLocaleView_Previews: PreviewProvider {
//    @EnvironmentObject var environmentals: EnvironmentalObjects
//    static var previews: some View {
//        TenseLocaleView(showTenseLocaleView: .constant(true))
//            .environmentObject(environmentals)
//    }
//}
