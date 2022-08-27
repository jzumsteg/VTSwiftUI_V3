//
//  AllVerbSettingsGroup.swift
//  Verbtrainer-Swift
//
//  Created by John Zumsteg on 9/18/18.
//  Copyright © 2018 verbtrainers. All rights reserved.
//

import Foundation
import FMDB

enum Selection_failure_cause {
    case no_failure
    case no_tense_selected
    case no_verb_type_selected
    case no_verb_ending_selected
    case no_person_number_selected
}


class Selection: ObservableObject {
//    var delegate: AppDelegate!
    @Published var verbStates: [String: VerbState] = [:] {
        didSet {
//            print("Changed...")
        }
    }
    var db: FMDatabase
    var tenseNumbers: [String: Int] = [:]
    var whereClauseUpdated: Bool = false
    var whereClause: String = ""
    var dirty = false

        
    //MARK: Shared Instance
    
    static let shared : Selection = {
        let instance = Selection()
        return instance
    }()
    
    private init( ) {
        // MARK: Local Variable
            // setup code
        db = DB.shared.stateDb
//        NotificationCenter.default.addObserver(self, selector: #selector(self.handleVerbSettingChange), name: .notification_verbSettingsChange, object: nil)
        populate()
    }
    
    
    func createVSDictionary(index: Int, value: Int, stop: inout Bool) -> Void {
        Log.print("index: \(index), value: \(value)")
        
    }
    
    @objc private func handleVerbSettingChange(notification: NSNotification) {
        Log.methodEnter()
        let userInfo = notification.userInfo
        guard let changedStates = userInfo?["NSUbiquitousKtoreChangedKeysKey"] else {
            Log.print("userInfo is nil!")
            return
        }
        for state in changedStates as! [String] {
            Log.print("Changing state: \(state)")
            // get the value from JzUserDefaults
            guard let newState = UDefs.bool(forKey: state) else {
                return
            }
            setAValue(name: state, value: newState)
            
        }
        Log.print("\(String(describing: userInfo))")
        
        
    }
    
 
    
    func setAValue(name: String, value: Bool) {
        
        // update the verbstates dictionary entry for this verbstate
        guard let vs_selected: VerbState = verbStates[name] else { return }
        vs_selected.verbState = value
//        UDefs.set(value: vs_selected.verbState, forKey: name)

        dirty = true
        
        switch vs_selected.verbType.lowercased() {
            case "simple":
            // if this is All Simple, set all the simple tense subtypes to this value
            if name.lowercased() == "all simple tenses" {
                for (_, vs) in verbStates {
                    if vs.verbSubType.lowercased() == "simple" && vs.verbState != value  {
                        vs.verbState = value
//                        UDefs.set(value: vs.verbState, forKey: vs.name)
                    }
                }
            }
            else {  // else this is not a change to "all simple tenses"
            // if any simple tenses are turned off, turn off the All Simple Tenses
                var onState = true
                var changed = true
                for (_, vs) in verbStates {
                    if vs.verbSubType.lowercased() == "simple" && vs.verbState == OFF {
                        onState = false
                        changed = true
                    }
                }
                if changed {
                    let vs: VerbState = verbStates["All Simple Tenses"]!
                    vs.verbState = onState ? ON : OFF
//                    UDefs.set(value: vs.verbState, forKey: vs.name)
                }
            }
            break
            
            case "compound":
                // if this is All Compound, set all the Compound subtypes to this value
                if name.lowercased() == "all compound tenses" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "compound" && vs.verbState != value {
                            vs.verbState = value
//                            UDefs.set(value: vs.verbState, forKey: vs.name)
                        }
                    }
                }
                else {
                    // do something with compound tenses
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "compound" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let vs = verbStates["All Compound Tenses"]!
                        vs.verbState = onState ? ON : OFF
                        UDefs.set(value: vs.verbState, forKey: vs.name)
                    }
                }

            break
            case "type":
                // if this is all types, set all the all types subtypes to this value
                if name.lowercased() == "all verb types" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "type" && vs.verbState != value {
                            vs.verbState = value
                            UDefs.set(value: vs.verbState, forKey: vs.name)
                        }
                    }
                }
                else {
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "type" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let vs = verbStates["All Verb Types"]!
                        vs.verbState = onState ? ON : OFF
//                        UDefs.set(value: vs.verbState, forKey: vs.name)
                    }
                    
                    
                }

            break
            case "ending":
                // if this is all endings, set all the all ending subtypes to this value
                if name.lowercased() == "all verb endings" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "ending" && vs.verbState != value {
                            vs.verbState = value
//                            UDefs.set(value: vs.verbState, forKey: vs.name)

                        }
                    }
                }
                else {
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        Log.print("vs.name:\(vs.name), vs.verbSubType: \(vs.verbSubType): state: \(vs.verbState)")
                        if vs.verbSubType.lowercased() == "ending" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let vs = verbStates["All Verb Endings"]!
                        vs.verbState = onState
//                        UDefs.set(value: vs.verbState, forKey: vs.name)
                    }

                }

            break
            case "person":
                // if this is all types, set all the all types subtypes to this value
                if name.lowercased() == "all persons/numbers" {
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "person" && vs.verbState != value {
                            vs.verbState = value
//                            UDefs.set(value: vs.verbState, forKey: vs.name)
                        }
                    }
                }
                else {
                    var changed = true
                    var onState = true
                    for (_, vs) in verbStates {
                        if vs.verbSubType.lowercased() == "person" && vs.verbState == OFF {
                            onState = false
                            changed = true
                        }
                    }
                    if changed {
                        let updateVs = verbStates["All Persons/numbers"]!
                        updateVs.verbState = onState
//                        UDefs.set(value: updateVs.verbState, forKey: updateVs.name)
                    }
                }
                
            break
        default:
            Log.print("Got an invalid type: \(vs_selected.verbType)")
        
        }
       
        NotificationCenter.default.post(name: .notification_selectionVerbStateChanged, object: nil)
       
        // now set the verbupdateflag to no
        whereClauseUpdated = false
        
    }
    
    func testSelection() -> Selection_failure_cause {
        /* have to test for the following:
        - is at least one tense, either simple or compound, selected
        - is at least one verb type selected
        - is at least one verb ending selected
        - is at least one person/number selected
         if selection fails one of these tests, it should return the failure cause.
         */
        var tenseSet = false
        var endingSet = false
        var personSet = false
        var typeSet = false
        
        for vs in verbStates {
            let vstate = verbStates[vs.key]
            if ((vstate?.verbType == "simple" || vstate?.verbType == "compound") && vstate?.verbState == true ) {
                tenseSet = true
            }
            if vstate?.verbType == "ending" && vstate?.verbState == true {
                endingSet = true
            }
            if vstate?.verbType == "person" && vstate?.verbState == true {
                personSet = true
            }
            if vstate?.verbType == "type" && vstate?.verbState == true {
                typeSet = true
            }
        }
        // tested everything...what we got?
        if tenseSet == false {
            return .no_tense_selected
        }
        if endingSet == false {
            return .no_verb_ending_selected
        }
        
        if personSet == false {
            return .no_person_number_selected
        }
        
        if typeSet == false {
            return .no_verb_type_selected
        }

        return .no_failure
    }
    
    func getAValue(name: String) -> Bool {
        if name == "" {
            return false
        }

        let vs: VerbState = verbStates[name]!
        return vs.verbState
    }
    
    func getState(name: String) -> VerbState? {
        if name == "" {
            return nil
        }

        guard let vs = verbStates[name] else {
            let verbState = VerbState()
            verbState.name = name
            verbState.verbState = true
            return verbState
        }
        return vs
        
    }
    
    func getWhereClause() -> String {
//        self.print()
        
//        if !whereClauseUpdated {
            var clause: String = ""
            let tenseStr = getTenseStr()
            let endingStr = getEndingStr()
            let typeStr = getTypeStr()
            let personStr = getPersonStr()
            let reflexiveStr = getReflexiveStr()
            let infStr = getInfinitiveStr()
            
            if tenseStr.length == 0 && endingStr.length == 0 && typeStr.length == 0 && personStr.length == 0  && infStr.length == 0 {
                return ""
            }
            else {
                var needAnd = false
                if tenseStr.length > 0 {
                    clause += "(" + tenseStr + ")"
                    needAnd = true
                }
                if endingStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += "(" + endingStr + ")"
                    needAnd = true
                }
                if typeStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += "(" + typeStr + ")"
                    needAnd = true
                }
                if personStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += "(" + personStr + ")"
                    needAnd = true
                }
                if reflexiveStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += "(" + reflexiveStr + ")"
                    needAnd = true
                }
                if infStr.length > 0 {
                    if needAnd {
                        clause += " AND "
                    }
                    clause += "(" + infStr + ")"
                }
            }
            
            if clause.length > 0 {
                clause = " WHERE " + clause
//            }/
        whereClauseUpdated = true
        whereClause = clause
        return clause
        }
        else {
            return whereClause
        }
        
    }
    
    func getInfinitiveStr() -> String {
//        var retVal = ""
        var infStr = String()
        var needOr = false
        switch Params.shared.verbSelectMode {
            case .use_all_verbs:
//            retVal = ""
            infStr = ""
            //FIX_ME: the line below was for screenshots. Remove it and uncomment the line above before production
//            infStr = "(infinitive = 'estar')"

        case .use_one_verb:
            infStr = " (infinitive = '\(escapedStr(Params.shared.currentSelectedSingleVerbInfinitive!))')"
            break
        case .use_verb_list:
            guard let verbList = Params.shared.currentSelectedVerblist else {
                return ""
            }
            for inf in verbList.infinitives {
                if needOr {
                    infStr += " OR "
                }
                infStr += " infinitive = '\(escapedStr(inf))'"
                needOr = true
            }
        }
        return infStr
    }
    
    func escapedStr( _ s: String) -> String {
        return s.replace(target: "'", withString: "''")
    }
    
    func getReflexiveStr() -> String {
        if getAValue(name: "Reflexive") == OFF {
            return " reflexive = 0 "
        }
        else {
            return ""
        }
        
    }
    func getTenseStr() -> String {
        var str: String = ""
        var retStr = " tense = 99 "
        var needOr = false
        
        if getAValue(name: "All Simple Tenses") == ON && getAValue(name: "All Compound Tenses") == ON {
            return ""
        }
        
        for (name, vs) in verbStates {
            if (vs.verbType == "simple" || vs.verbType == "compound") && vs.summary == false && vs.verbSubType != "summary" {
                if vs.verbState == ON {
                    if needOr {
                        str += " OR "
                    }
                    // get the number for this tense
                    let tenseNumber = tenseNumbers[name]!
                    str = str + " tense = \(tenseNumber)"
                    needOr = true
                }
            }
        }
        if str.length > 0 {
            retStr = " \(str) "
        }
        else {
            retStr = " tense = 999 " // this will ensure no tenses are selected
        }
        return retStr
    }

    func getEndingStr() -> String {
        var str: String = ""
        var needOr = false
        
        if getAValue(name: "All Verb Endings") == ON {
            return ""
        }
        
        for (_, vs) in verbStates {
            if vs.verbType == "ending" && vs.summary == false {
                if vs.verbState == ON {
                    if needOr {
                        str += " OR "
                    }
                    str += " ending = '\(vs.name)' "
                    needOr = true
                }
            }
        }
        if str.length == 0 {
            str = " ending = 'no ending' " // ensures no endings are selected
        }
        return str
    }
    
    func getPersonStr() -> String {
        var personStr = ""
        var needOr: Bool = false
        
        let vsState: VerbState = self.verbStates[Persons.allPersons]!
        switch vsState.verbState {
            case OFF:  // All is off, so have to check each individual verbstate
                if self.getAValue(name: Persons.person1) == ON {
                    personStr = " genericnumber2 = 1 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person2) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 2 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person3) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 3 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person4) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 4 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person5) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 5 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person6) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 6 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person7) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 7 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person8) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 8 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person9) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 9 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person10) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 10 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person11) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 11 ";
                    needOr = true;
                }
                
                if self.getAValue(name: Persons.person12) == ON {
                    if needOr == true {
                        personStr += " OR "
                    }
                    personStr += " genericnumber2 = 12 ";
                    needOr = true;
                }
            
                if personStr.count == 0 {
                    personStr = " genericnumber2 = 999 " // none are selected, so make sure nothing is selected for genericnumber2
            }
        case ON:
            personStr = " genericnumber2 > 0 AND genericnumber2 < 13 "
        default:
            personStr = " genericnumber2 > 0 AND genericnumber2 < 13 "
      }  // switch
        
        return personStr;
        
    }
    
    func getTypeStr() -> String {
        var str: String = ""
        var needOr = false
        
        if getAValue(name: "All Verb Types") == ON {
            return ""
        }
        
        for (_, vs) in verbStates {
            if vs.verbType == "type" && vs.summary == false {
                if vs.verbState == ON {
                    if needOr {
                        str += " OR "
                    }
//                    let vsname = vs.name.lowercased().replace(target: "-", withString: "")
                    str = str + " \(vs.whereStr!) "
                    needOr = true
                }
            }

        }
        if str.length == 0 {
            str = " (regular = 0 AND irregular = 0 AND stemchanging = 0 AND orthochanging = 0 AND reflexive = 0) "
        }
        return str
    }
    
    func getEndingAndTypeClauseOnly() -> String {
        let endingStr = getEndingStr()
        let typeStr = getTypeStr()
        var needAnd = false
        var retStr = ""
        
        if (endingStr.length == 0 && typeStr.length == 0) {
            return retStr
        }
        
        if (typeStr.length > 0) {
            retStr = typeStr
            needAnd = true
        }
        
        if (endingStr.length > 0) {
            if (needAnd == true) {
                retStr = retStr + " AND "
            }
            retStr += endingStr
        }
        
        if (retStr.length > 0) {
            retStr = " WHERE " + retStr
        }
        
        return retStr
        }



    func populate() {
        // process is this:
        // get everything from the local verbsetting database
        // if iCloud is available,
        //      update the local values from the iCloudKit
        //      update the local database
        // but... what if the local values are more recent than the Cloud values. I have no way to know that.
        var sqlStr = "SELECT * FROM verbsettings;"
        guard let rs: FMResultSet = db.executeQuery(sqlStr, withArgumentsIn: []) else {
            Log.print("db.executeQuery failed \(db.lastError())")
            return
        }
        while rs.next() {
            let vs: VerbState = VerbState()
            vs.name = rs.string(forColumn: "setting_name") ?? "setting_name error"
//            vs.name = vs.name.lowercased()
            vs.altName = rs.string(forColumn: "setting_name_alt") ?? "alt_setting-name error"
//            vs.verbState = rs.bool(forColumn: "setting_state")
            vs.verbType = rs.string(forColumn: "setting_type") ?? "setting_type error"
            vs.verbSubType = rs.string(forColumn: "setting_subtype") ?? "setting_subtype error"
            vs.viewRow = rs.int(forColumn: "viewrow")
            vs.summary = rs.bool(forColumn: "summary")
            vs.whereStr = rs.string(forColumn: "whereStr") ?? "wherestr error"
            
             if let verbState = UDefs.bool(forKey: vs.name) {
                vs.verbState = verbState
            }
            else {
                vs.verbState = true
            }
            verbStates[vs.name] = vs
        }
    
        
        sqlStr = "SELECT setting_name, tenseNumber FROM verbsettings WHERE tenseNumber > 0;"
        guard let rs1 = db.executeQuery(sqlStr, withArgumentsIn: []) else {
            Log.print("db.executeQuery failed \(db.lastError())")
            return
        }
        while rs1.next() {
            let tenseName = rs1.string(forColumn: "setting_name")
            let tenseNumber = Int(rs1.int(forColumn: "tenseNumber"))
            self.tenseNumbers[tenseName!] = tenseNumber
        }
    }
   
    func saveToUserDefaults() {
        for (_, vs) in verbStates {
            UDefs.set(value: vs.verbState, forKey: vs.name)
        }
    }
 
    private func updateSettingsInJzUserDefaults(settingName: String, settingValue: Bool) {
        UDefs.set(value: settingValue, forKey: settingName)

    }
    
    public func getVerbStateArray(vsType: String) -> [VerbState] {
        // return all the simple verbstates, in viewRow order
        var vsArray = [VerbState]()
        let vsFilteredDict = verbStates.filter {$0.value.verbType == vsType}
        for (_, vs) in vsFilteredDict {
            vsArray.append(vs)
        }
        
        let sortedArray = vsArray.sorted { (vs1, vs2) -> Bool in
            vs1.viewRow < vs2.viewRow }

        return sortedArray
    }
    
    func printYourself() {
        Log.print("Selection:")
        for (_, vs) in verbStates {
            Log.print("   state:   \(vs.name) = \(vs.verbState)")
            Log.print("   default: \(UDefs.bool(forKey: vs.name)!)")
        }

    }
    
    
}


