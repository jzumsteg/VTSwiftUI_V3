//
//  SettingsSelectionView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 12/2/21.
//

import SwiftUI

struct SettingsSelectionView: View {
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @ObservedObject var settingsModel = Selection.shared
    @ObservedObject var vstate = VerbState()
    @StateObject var model = SettingsSelectionModel()
    @State var showAlert: Bool = false
    
    @State var simpleAll = VerbState()
    @State var simple1 = VerbState()
    @State var simple2 = VerbState()
    @State var simple3 = VerbState()
    @State var simple4 = VerbState()
    @State var simple5 = VerbState()
    @State var simple6 = VerbState()
    @State var simple7 = VerbState()
    @State var simple8 = VerbState()
    @State var simple9 = VerbState()
    
    @State var compoundAll = VerbState()
    @State var compound1 = VerbState()
    @State var compound2 = VerbState()
    @State var compound3 = VerbState()
    @State var compound4 = VerbState()
    @State var compound5 = VerbState()
    @State var compound6 = VerbState()
    @State var compound7 = VerbState()
    @State var compound8 = VerbState()
    @State var compound9 = VerbState()
    
    @State var typeAll = VerbState()
    @State var type1 = VerbState()
    @State var type2 = VerbState()
    @State var type3 = VerbState()
    @State var type4 = VerbState()
    @State var type5 = VerbState()
    @State var type6 = VerbState()
    
    @State var personAll = VerbState()
    @State var person1 = VerbState()
    @State var person2 = VerbState()
    @State var person3 = VerbState()
    @State var person4 = VerbState()
    @State var person5 = VerbState()
    @State var person6 = VerbState()
    @State var person7 = VerbState()
    @State var person8 = VerbState()
    @State var person9 = VerbState()
    @State var person10 = VerbState()
    @State var person11 = VerbState()

    @State var endingAll = VerbState()
    @State var ending1 = VerbState()
    @State var ending2 = VerbState()
    @State var ending3 = VerbState()

    
    init() {
        UITableView.appearance().sectionFooterHeight = 0  // reduces spacing between section titles
        
//        let allSettings = State(initialValue: AllVerbSettingsGroup())
        _simpleAll = State(initialValue: settingsModel.getState(name: "All Simple Tenses")!)
        _simple1 = State(initialValue: settingsModel.getState(name: "presente")!)
        _simple2 = State(initialValue: settingsModel.getState(name: "imperfecto")!)
        _simple3 = State(initialValue: settingsModel.getState(name: "pretérito")!)
        _simple4 = State(initialValue: settingsModel.getState(name: "futuro")!)
        _simple5 = State(initialValue: settingsModel.getState(name: "condicional presente")!)
        _simple6 = State(initialValue: settingsModel.getState(name: "presente de subjuntivo")!)
        _simple7 = State(initialValue: settingsModel.getState(name: "imperfecto de subjuntivo")!)
        _simple8 = State(initialValue: settingsModel.getState(name: "imperfecto de subjuntivo (alt)")!)
        _simple9 = State(initialValue: settingsModel.getState(name: "imperativo")!)
        
        _compoundAll = State(initialValue: settingsModel.getState(name: "All Compound Tenses")!)
        _compound1 = State(initialValue: settingsModel.getState(name: "perfecto de indicativo")!)
        _compound2 = State(initialValue: settingsModel.getState(name: "pluscuamperfecto de indic.")!)
        _compound3 = State(initialValue: settingsModel.getState(name: "pretérito anterior")!)
        _compound4 = State(initialValue: settingsModel.getState(name: "futuro perfecto")!)
        _compound5 = State(initialValue: settingsModel.getState(name: "condicional compuesto")!)
        _compound6 = State(initialValue: settingsModel.getState(name: "perfecto de subjuntivo")!)
        _compound7 = State(initialValue: settingsModel.getState(name: "pluscuam. de subj.")!)
        _compound8 = State(initialValue: settingsModel.getState(name: "pluscuam. de subj. (alt)")!)
        
        _typeAll = State(initialValue: settingsModel.getState(name: "All Verb Types")!)
        _type1 = State(initialValue: settingsModel.getState(name: "Regular")!)
        _type2 = State(initialValue: settingsModel.getState(name: "Irregular")!)
        _type3 = State(initialValue: settingsModel.getState(name: "Stem-changing")!)
        _type4 = State(initialValue: settingsModel.getState(name: "Ortho-changing")!)
        _type5 = State(initialValue: settingsModel.getState(name: "Reflexive")!)
//        _type6 = State(initialValue: settingsModel.getState(name: "Use vosotros")!)

        _personAll = State(initialValue: settingsModel.getState(name: "All Persons/numbers")!)
        _person1 = State(initialValue: settingsModel.getState(name: "yo")!)
        _person2 = State(initialValue: settingsModel.getState(name: "tú")!)
        _person3 = State(initialValue: settingsModel.getState(name: "ella")!)
        _person4 = State(initialValue: settingsModel.getState(name: "él")!)
        _person5 = State(initialValue: settingsModel.getState(name: "Ud.")!)
        _person6 = State(initialValue: settingsModel.getState(name: "nosotros")!)
        _person7 = State(initialValue: settingsModel.getState(name: "vosotros")!)
        _person8 = State(initialValue: settingsModel.getState(name: "ellos")!)
        _person9 = State(initialValue: settingsModel.getState(name: "ellas")!)
        _person10 = State(initialValue: settingsModel.getState(name: "Uds.")!)
        _person11 = State(initialValue: settingsModel.getState(name: "vosotros")!)

        _endingAll = State(initialValue: settingsModel.getState(name: "All Verb Endings")!)
        _ending1 = State(initialValue: settingsModel.getState(name: "-ar")!)
        _ending2 = State(initialValue: settingsModel.getState(name: "-ir")!)
        _ending3 = State(initialValue: settingsModel.getState(name: "-er")!)

    }
    
    //", "Yo","Tú","Ella","El","Ud.","Nosotros","Vos","Ellos","Ellas","Uds."

    var body: some View {
        VStack {
            Text("Verb Selection").font(.largeTitle)
                .padding(.top, 10)
            Text("Tap a category to open, then select criteria you want to include in drills.")
//                .padding()
            Form {
                Section {
                    DisclosureGroup() {
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simpleAll, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple1, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple2, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple3, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple4, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple5, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple6, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple7, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple8, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: simple9, model: model)
                    } // discolosure group
                    label: {
                        Text("Simple Tenses")
                            .font(.headline)
                    }
                } 

                
                Section {
                    DisclosureGroup() {
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compoundAll, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound1, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound2, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound3, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound4, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound5, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound6, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound7, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: compound8, model: model)
                    } // discolosure group
                    label: {
                        Text("Compound Tenses")
                            .font(.headline)
                    }  // label
                } // section

                
                Section {
                    DisclosureGroup() {
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: typeAll, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: type1, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: type2, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: type3, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: type4, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: type5, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: type6, model: model)
                    } // discolosure group
                    label: {
                        Text("Verb types")
                            .font(.headline)
                    }  // label
                } // section
                
                Section {
                    DisclosureGroup() {
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: personAll, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person1, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person2, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person3, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person4, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person5, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person6, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person7, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: person8, model: model)
                        VStack {
                            SettingsSelectionToggleRow(settings: settingsModel, verbState: person9, model: model)
                            SettingsSelectionToggleRow(settings: settingsModel, verbState: person10, model: model)
                                .padding(.top, 10)
                        } // VStack:186
                    } // discolosure group
                    label: {
                        Text("Person/number")
                            .font(.headline)
                    }  // label
                } // section
                
                Section {
                    DisclosureGroup() {
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: endingAll, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: ending1, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: ending2, model: model)
                        SettingsSelectionToggleRow(settings: settingsModel, verbState: ending3, model: model)

                    } // discolosure group
                    label: {
                        Text("Endings")
                            .font(.headline)
                    }  // label
                } // section

            } // form
            .padding(.bottom, 10)

            if model.verbCount > 0 {
                Text("\(environmentals.drillSource) Current number of verb forms selected: \(model.verbCount)")
                    .padding(.bottom, 20)
                    .font(.system(size:14).italic())

            }
            else {
                Text("Problem: your choices eliminate all verb forms. Please correct this.")
                    .padding(.bottom, 20)
                    .foregroundColor(Color.red)
            }


        } // VStack:116
        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.width * 0.65 : UIScreen.main.bounds.width * 0.95)
        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.height * 0.65 : UIScreen.main.bounds.height * 0.85)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .border(Color("BlueViewBorder"))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(UIDevice.current.userInterfaceIdiom == .pad ? Color.blue : Color.clear, lineWidth: 1)
        )
        .onAppear {
            model.setup()
        }
//        .onTapGesture {
//            model.verbGenerator.calculateRecordCount()
//        }
        
        .alert("Your selections eliminate all verb forms. Return to the view and correct this problem.", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        

    } // varbody:someView:115
}

//struct SettingsSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsSelectionView()
//    }
//}
