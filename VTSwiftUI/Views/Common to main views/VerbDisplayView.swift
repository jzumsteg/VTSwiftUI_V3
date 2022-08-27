//
//  VerbDisplayView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/13/21.
//

import SwiftUI

//struct DescriptionLabel: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: 20, weight: .regular, design: .default).italic())
//            .foregroundColor(.gray)
//            .padding(.bottom, -20)
//    }
//}
//struct VerbLabel: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: 32, weight: .bold, design: .rounded))
//            .foregroundColor(.blue)
//            .padding(.bottom, -15)
//    }
//}
struct VerbDisplayView: View {
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @EnvironmentObject var verblistManagment: VerblistManagementModel
        
    
    @Binding var showAnswerSwitch: Bool
    @State var showTranslationSwitch: Bool = false
    @State var helpViewDisplayed: Bool = false
    @State var closeSwitch: Bool = false
//    var viewType: view_displayed
    
    let labelWidthPercentage = 0.95
    let verbPartPercentage = 0.95
    let labelHeight = 30.0
    let verbWidth = 300.0
    let verbHeight = 30.0
    let bottomLinePadding = 2.0
    let interLinePadding = -15.0
    
//    init() {
//        environmentals.currentVerbInfinitive = verbGenerator.displayVerb.infinitive
//    }
    var body: some View {
        ZStack {
//            PrintFromView(environmentals.printYourself())
            GeometryReader {geometry in
                VStack {
                    HStack {
                        Text(LanguageGlobals.infinitiveLabel)
                        //                            .frame(width: geometry.size.width * labelWidthPercentage, height: labelHeight, alignment: .leading)
                            .verbDescLabelStyle()
                        Spacer()
                        
                    } // HStack:54
                    .frame(width: geometry.size.width * labelWidthPercentage, height: labelHeight, alignment: .leading)
                    
                    
                    Text("\(environmentals.currentInfinitiveDisplayMode == .language ? verbGenerator.displayVerb.infinitive : verbGenerator.displayVerb.english)")
                        .verbPartLabelStyle()

                        .frame(width: geometry.size.width * verbPartPercentage, height: verbHeight, alignment: .leading)
                    //                        .padding(.top, -10)
                    
                    
                    Text(LanguageGlobals.pronounLabel)
                        .frame(width: geometry.size.width * labelWidthPercentage, height: labelHeight, alignment: .leading)
                        .verbDescLabelStyle()
                    //                        .padding(.top, 10)
                    
                    Text("\(verbGenerator.displayVerb.number)")
                        .verbPartLabelStyle()
                        .frame(width: geometry.size.width * verbPartPercentage, height: verbHeight, alignment: .leading)
                    //                        .padding(.top, -10)
                    
                    Text(LanguageGlobals.tenseLabel)
                        .frame(width: geometry.size.width * labelWidthPercentage, height: labelHeight, alignment: .leading)
                        .verbDescLabelStyle()
                    //                        .padding(.top, 10)
                    
                    Text("\(verbGenerator.displayVerb.tense)")
                        .verbLabel2LinesStyle()
                        .frame(width: geometry.size.width * verbPartPercentage, height: verbHeight * 3, alignment: .topLeading)
                        .lineLimit(nil)
                    Spacer()
                } // VStack:53
//                .frame(width: geometry.size.height * 0.4)
 
            } // GeometryReader:52
//            .padding(.leading, 15)
//            .padding(.trailing, 15)
            
            if helpViewDisplayed == true {
                SelectDrillSourceView(closeSwitch: $closeSwitch)
                
            }
        } // ZStack:50
        
    } // varbody:someView:49
    
} //struct



//}
//
//struct VerbDisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerbDisplayView()
//    }
//}
