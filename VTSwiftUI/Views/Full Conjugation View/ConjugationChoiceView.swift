//
//  VerbChoiceView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/21/22.
//

import SwiftUI

struct ConjugationChoiceView: View {
    @EnvironmentObject var environmentals:EnvironmentalObjects
    @StateObject var model: FullConjugationViewModel = FullConjugationViewModel()
    @StateObject var model2 = SelectSingleVerbViewModel()
    @State private var srchStr: String = ""
    @State private var showConjView: Bool = false
    
    @State private var infType = Infinitive_list_display()
    @State private var selectedInfinitive: String = String()
    
    var listTextSize = 12.0
    @Binding var infStr: String
    
    init(infStr: Binding<String>) {
        self._infStr = infStr
    }
    
    var body: some View {
//        var infStr: String = self.selectedInfinitive
        HStack {
            Spacer()
  
        VStack {
//            GeometryReader {geometry in
                VStack (alignment: .center) {
                    TextField("Enter search text here", text: $srchStr)
                        .onChange(of:srchStr) { newValue in
                            Log.print("schrStr: \(srchStr), newValue: \(newValue)!")
                            model2.getFilterdInfinitives(searchStr: newValue.lowercased())
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding(.trailing, 15)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(Infinitives.getInfinitivesIntoListArray(str: srchStr, language: infType), id: \.self) { inf in
                            HStack {
                                Text("\(inf)")
                                    .padding(.top, 6)
                                    .padding(.bottom, 6)
                                    .onTapGesture {
                                        self.selectedInfinitive = Infinitives.theInfinitive(textStr: inf, language: self.infType)
                                        self.infStr = selectedInfinitive.copy() as! String  // do  deep copy because there is a bug that prevents using a @State property.
//                                        environmentals.selectedInfinitive = selectedInfinitive
                                        Log.print("SelectedInfinitive: \(self.selectedInfinitive)")
                                        Log.print("infStr: \(self.infStr)")
                                        showConjView = true
                                    }
                                Spacer()
                            } // HStack:37
                        } // ForEach:36
                        .navigationBarTitle("Conjugations")
                    } // ScrollView:35

                } // VStack:26
                .frame(maxWidth: max(350, UIScreen.main.bounds.width * 0.55))


                
                .sheet(isPresented: $showConjView) {
                    PrintFromView(".sheet: |\($infStr.wrappedValue)|")
                    FullConjugationView(inf: infStr, closeSwitch: $showConjView)
                } // .sheet:57

//                .sheet(item: $selectedInfinitive, onDismiss: nil, content: { data in
//                    FullConjugationView(inf: data, closeSwitch: $showConjView)
//                            })
//            } // GeometryReader:25
 
        } // VStack:24
            Spacer()
        } // hstack
        .navigationBarTitle("Conjugations", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)
 
    } // varbody:someView:21
}
//
//struct VerbChoiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerbChoiceView()
//    }
//}
