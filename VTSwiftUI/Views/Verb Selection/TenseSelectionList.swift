//
//  FormList.swift
//  CollapsibleList
//
//  Created by John Zumsteg on 11/19/21.
//

import SwiftUI


struct TenseSelectionList: View {
    var model = TenseSelectionListModel()
    @State var isProfileExpanded = true
    // simple tenses
    var settings = AllVerbSettingsGroup()
    @State var tenses: [String] = kSimpleTenses
    @State var tense0: Bool
    @State var tense1: Bool
    @State var tense2: Bool
    @State var tense3: Bool
    @State var tense4: Bool
    @State var tense5: Bool
    @State var tense6: Bool
    @State var tense7: Bool
    @State var tense8: Bool
    @State var tense9: Bool
    
    init() {
        _tense0 = State(initialValue: settings.getState(name: "All Simple Tenses", type: .simple)!)
        _tense1 = State(initialValue: settings.getState(name: "presente", type: .simple)!)
        _tense2 = State(initialValue: settings.getState(name: "imperfecto", type: .simple)!)
        _tense3 = State(initialValue: settings.getState(name: "pretérito", type: .simple)!)
        _tense4 = State(initialValue: settings.getState(name: "futuro", type: .simple)!)
        _tense5 = State(initialValue: settings.getState(name: "condicional presente", type: .simple)!)
        _tense6 = State(initialValue: settings.getState(name: "presente de subjuntivo", type: .simple)!)
        _tense7 = State(initialValue: settings.getState(name: "imperfecto de subjuntivo", type: .simple)!)
        _tense8 = State(initialValue: settings.getState(name: "imperfecto de subjuntivo (alt)", type: .simple)!)
        _tense9 = State(initialValue: settings.getState(name: "imperativo", type: .simple)!)
    }

    // compound tenses
//    @State var tense9: Bool = AllVerbSettingsGroup().getState(name: "perfecto de indicativo", type: .compound)!
//    @State var tense10: Bool = AllVerbSettingsGroup().getState(name: "pluscuamperfecto de indic.", type: .compound)!
//    @State var tense11: Bool = AllVerbSettingsGroup().getState(name: "futuro perfecto", type: .compound)!
//    @State var tense12: Bool = AllVerbSettingsGroup().getState(name: "pretérito anterior", type: .compound)!
//    @State var tense13: Bool = AllVerbSettingsGroup().getState(name: "condicional compuesto", type: .compound)!
//    @State var tense14: Bool = AllVerbSettingsGroup().getState(name: "perfecto de subjuntivo", type: .compound)!
//    @State var tense15: Bool = AllVerbSettingsGroup().getState(name: "pluscuam. de subj.", type: .compound)!
//    @State var tense16: Bool = AllVerbSettingsGroup().getState(name: "pluscuam. de subj. (alt)", type: .compound)!



    var body: some View {
        VStack {
            Text("Tense Selection").font(.largeTitle)
            Text("Tap a tense category to open, then select tenses you want for drilling.")
            Form {
                Section {
                    DisclosureGroup {
                        Toggle(kSimpleTenses[0], isOn: $tense0.didSet {(state) in
                            print("New value for \(kSimpleTenses[0]) is: \(state)")
//                            updateSettings(type: SettingsType, state: state)
                            settings.setState(setting_name: kSimpleTenses[0], state: state)
                           })
                        Toggle(kSimpleTenses[1], isOn: $tense1.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[1], state: state)
                           })
                        Toggle(kSimpleTenses[2], isOn: $tense2.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[2], state: state)
                           })
                        Toggle(kSimpleTenses[3], isOn: $tense3.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[3], state: state)
                           })
                        Toggle(kSimpleTenses[4], isOn: $tense4.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[4], state: state)
                           })
                        Toggle(kSimpleTenses[5], isOn: $tense5.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[5], state: state)
                           })
                        Toggle(kSimpleTenses[6], isOn: $tense6.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[6], state: state)
                           })
                        Toggle(kSimpleTenses[7], isOn: $tense7.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[7], state: state)

                           })
                        Toggle(kSimpleTenses[8], isOn: $tense8.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[8], state: state)

                           })
                        Toggle(kSimpleTenses[9], isOn: $tense9.didSet {(state) in
                            print("New value is: \(state)")
                            settings.setState(setting_name: kSimpleTenses[9], state: state)

                           })


                    } // disclosure group
                label: {
                        Text("Simple Tenses")
                            .font(.headline)
                    }  // label
                } // section
                
//                Section {
//                    DisclosureGroup {
//                        Toggle("perfecto de indicativo", isOn: .constant(true))
//                        Toggle("pluscuamperfecto de indic.", isOn: .constant(true))
//                        Toggle("futuro perfecto", isOn: .constant(false))
//                        Toggle("pretérito anterior", isOn: .constant(false))
//                        Toggle("condicional compuesto", isOn: .constant(false))
//                        Toggle("perfecto de subjuntivo", isOn: .constant(false))
//                        Toggle("pluscuam. de subj.", isOn: .constant(false))
//                        Toggle("pluscuam. de subj. (alt)", isOn: .constant(false))
//                    } label: {
//                        Text("Compound Tenses")
//                            .font(.headline)
//                    }
//                }
            }  // Form
        } // VStack:54
}  // varbody:someView:53
//    func updateSettings(settingType: SettingsType, state: Bool) {
//
//    }
}


struct FormList_Previews: PreviewProvider {
    var tenses: [Bool]
    static var previews: some View {
        TenseSelectionList()
    }
}

extension Binding {
    func didSet(execute: @escaping (Value) -> Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                self.wrappedValue = $0
                execute($0)
                print("at binding, set \(self) to \(self.wrappedValue)")
            }
        )
    }
}
