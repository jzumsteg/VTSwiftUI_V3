//
//  VTSwiftUITests.swift
//  VTSwiftUITests
//
//  Created by John Zumsteg on 11/11/21.
//

import XCTest
@testable import VTSwiftUI
//@testable import Verbos-UI

class VTSwiftUITests2: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTestModel() {
        var testModel = TestViewModel()
        testModel.setup()
        XCTAssert(testModel.testType == .timedSetVerbs)
        
        testModel.startTest()
     
        
    }
    
    func testHistoryList() {
        let hl = HistoryViewModel()
        hl.getHistoryList()
        XCTAssertTrue(hl.historyList.count > 0)
    }
    
    func testVerblistManagementModel() {
        let vlist = Verblist(verblistname: "List 1")
        vlist.infinitives.append("dar")
        vlist.infinitives.append("poner")
        vlist.save()

        let vlist2 = Verblist(verblistname: "List 2")
        vlist2.infinitives.append("dar")
        vlist2.infinitives.append("poner")
        vlist2.save()
        let vlmm = VerblistManagementModel()
        print("\(vlmm.verblists)")
    }

    func testVerblists() {
        let verblists = Verblists()
        var verblistURLs = [URL]()
        XCTAssertTrue(verblistURLs.count == 0)
        
        // create and save some verblists
        let vlist = Verblist(verblistname: "List 1")
        vlist.infinitives.append("dar")
        vlist.infinitives.append("poner")
        vlist.save()

        let vlist2 = Verblist(verblistname: "List 2")
        vlist2.infinitives.append("dar")
        vlist2.infinitives.append("poner")
        vlist2.save()

        verblistURLs = verblists.populateVerblistURLs()
        print("Coundt: \(verblistURLs.count)")
        XCTAssertTrue(verblistURLs.count == 2)
        
        for url in verblistURLs {
            let verblist = Verblist()
            verblist.retrieveLocally(url: url)
            verblists.verblists.append(verblist)
            
            XCTAssertTrue(verblists.verblists.count == 2)
        }
        
        for verblist in verblists.verblists {
            verblist.printYourself()
        }
        

    }
    
//      func testVerbSettingGroup() {
//          let v = OneVerbSettingGroup(type: .simple)
//          let testState = "presente"
//
//          XCTAssert(v.type == .simple)
//          var vs = v.setState(setting_name: testState, state: false)!
//          XCTAssert(v.getState(setting_name: testState) == false)
//          XCTAssert(vs.verbState == false)
//
//          XCTAssertFalse( UDefs.bool(forKey: "presente")!)
//          vs = v.setState(setting_name: testState, state: true)!
//          XCTAssert(v.getState(setting_name: testState) == true)
//          XCTAssert(vs.verbState == true)
//          XCTAssertTrue( UDefs.bool(forKey: "presente")!)
//      }
    
    func testGetVerbstates() throws {
        let v = AllVerbSettingsGroup()
        let vs = v.getAllVerbStates()
        print(vs)
    }
    
//    func testSimpleTenses() {
//        let v = OneVerbSettingGroup(type: .simple)
//
//        let allStr  = "All Simple Tenses".lowercased()
//        var vs = v.setState(setting_name: allStr, state: true)
//        XCTAssertNotNil(vs)
//
//        XCTAssert(v.getState(setting_name: allStr) == true)
//        XCTAssert(v.getState(setting_name: "presente") == true)
//        XCTAssert(v.getState(setting_name: "imperfecto") == true)
//
//        vs = v.setState(setting_name: allStr, state: false)
//        XCTAssert(v.getState(setting_name: allStr) == false, "Must not have returend a false.")
//        XCTAssert(v.getState(setting_name: "presente") == false, "Must not have returned false.")
//        XCTAssert(v.getState(setting_name: "imperfecto") == false, "Must not have returned false.")
//
//        // see if setting presente and imperfecto to true also sets all simple tenses to true
//
//        vs = v.setState(setting_name: "presente", state: true)
//        vs = v.setState(setting_name: "imperfecto", state: true)
//        vs = v.setState(setting_name: "pretérito", state: true)
//        vs = v.setState(setting_name: "futuro", state: true)
//        vs = v.setState(setting_name: "condicional presente", state: true)
//        vs = v.setState(setting_name: "presente de subjuntivo", state: true)
//        vs = v.setState(setting_name: "imperfecto de subjuntivo", state: true)
//        vs = v.setState(setting_name: "imperfecto de subjuntivo (alt)", state: true)
//        vs = v.setState(setting_name: "imperativo", state: true)
//
//        var ret: Bool = v.getState(setting_name: "all simple tenses")!
//        XCTAssertTrue(ret)
//
//        // set one verbstate to false and see if the all simple turnns to false
//        vs = v.setState(setting_name: "imperfecto de subjuntivo (alt)", state: false)
//        ret = v.getState(setting_name: "all simple tenses")!
//        XCTAssertFalse(ret)
//
//   }
//
//    func testCompoundTenses() {
//        let c = OneVerbSettingGroup(type: .compound)
//        let allStr  = "All Compound Tenses".lowercased()
//        var vs = c.setState(setting_name: allStr, state: true)
//        XCTAssertNotNil(vs)
//        XCTAssert(c.getState(setting_name: allStr) == true)
//        XCTAssert(c.getState(setting_name: "perfecto de indicativo") == true)
//        XCTAssert(c.getState(setting_name: "pluscuamperfecto de indic.") == true)
//
//        vs = c.setState(setting_name: allStr, state: false)
//        XCTAssert(c.getState(setting_name: allStr) == false, "Must not have returend a false.")
//        XCTAssert(c.getState(setting_name: "perfecto de indicativo") == false, "Must not have returned false.")
//        XCTAssert(c.getState(setting_name: "pluscuamperfecto de indic.") == false, "Must not have returned false.")
//
//        // see if setting presente and imperfecto to true also sets all simple tenses to true
//
//        vs = c.setState(setting_name: "perfecto de indicativo", state: true)
//        vs = c.setState(setting_name: "pluscuamperfecto de indic.", state: true)
//        vs = c.setState(setting_name: "futuro perfecto", state: true)
//        vs = c.setState(setting_name: "pretérito anterior", state: true)
//        vs = c.setState(setting_name: "condicional compuesto", state: true)
//        vs = c.setState(setting_name: "presente de subjuntivo", state: true)
//        vs = c.setState(setting_name: "perfecto de subjuntivo", state: true)
//        vs = c.setState(setting_name: "pluscuam. de subj.", state: true)
//        vs = c.setState(setting_name: "pluscuam. de subj. (alt)", state: true)
//        var ret: Bool = c.getState(setting_name: allStr)!
//        XCTAssertTrue(ret)
//
//        // set one verbstate to false and see if the all simple turnns to false
//        vs = c.setState(setting_name: "pluscuam. de subj.", state: false)
//        ret = c.getState(setting_name: allStr)!
//        XCTAssertFalse(ret)
//
//    }
//
//    func testEndings() {
//        let c = OneVerbSettingGroup(type: .ending)
//        let allStr  = "All Verb Endings".lowercased()
//        var vs = c.setState(setting_name: allStr, state: true)
//        XCTAssertNotNil(vs)
//
//        XCTAssert(c.getState(setting_name: allStr) == true)
//        XCTAssert(c.getState(setting_name: "-ar") == true)
//        XCTAssert(c.getState(setting_name: "-ir") == true)
//
//        vs = c.setState(setting_name: allStr, state: false)
//        XCTAssert(c.getState(setting_name: allStr) == false, "Must not have returend a false.")
//        XCTAssert(c.getState(setting_name: "-ar") == false, "Must not have returned false.")
//        XCTAssert(c.getState(setting_name: "-er") == false, "Must not have returned false.")
//
//        // see if setting presente and imperfecto to true also sets all simple tenses to true
//
//        vs = c.setState(setting_name: "-ar", state: true)
//        vs = c.setState(setting_name: "-ir", state: true)
//        vs = c.setState(setting_name: "-er", state: true)
//
//        var ret: Bool = c.getState(setting_name: allStr)!
//        XCTAssertTrue(ret)
//
//        // set one verbstate to false and see if the all simple turnns to false
//        vs = c.setState(setting_name: "-er", state: false)
//        ret = c.getState(setting_name: allStr)!
//        XCTAssertFalse(ret)
//    }
//
//    func testPersons() {
//        let c = OneVerbSettingGroup(type: .person)
//        let allStr  = "All Persons/numbers".lowercased()
//        var vs = c.setState(setting_name: allStr, state: true)
//        XCTAssertNotNil(vs)
//        XCTAssert(c.getState(setting_name: allStr) == true)
//        XCTAssert(c.getState(setting_name: "yo") == true)
//        XCTAssert(c.getState(setting_name: "tú") == true)
//
//        vs = c.setState(setting_name: allStr, state: false)
//        XCTAssert(c.getState(setting_name: allStr) == false, "Must not have returend a false.")
//        XCTAssert(c.getState(setting_name: "yo") == false, "Must not have returned false.")
//        XCTAssert(c.getState(setting_name: "tú") == false, "Must not have returned false.")
//
//        // see if setting presente and imperfecto to true also sets all simple tenses to true
//
//        vs = c.setState(setting_name: "yo", state: true)
//        vs = c.setState(setting_name: "tú", state: true)
//        vs = c.setState(setting_name: "él", state: true)
//        vs = c.setState(setting_name: "ella", state: true)
//        vs = c.setState(setting_name: "ud.", state: true)
//        vs = c.setState(setting_name: "nosotros", state: true)
//        vs = c.setState(setting_name: "vosotros", state: true)
//        vs = c.setState(setting_name: "ellos", state: true)
//        vs = c.setState(setting_name: "ellas", state: true)
//        vs = c.setState(setting_name: "uds.", state: true)
//        vs = c.setState(setting_name: "vos", state: true)
//        var ret: Bool = c.getState(setting_name: allStr)!
//
//        for (n, v) in c.verbStates {
//            print("\(n) - \(v.verbState)")
//        }
//        XCTAssertTrue(ret)
//
//        // set one verbstate to false and see if the all simple turnns to false
//        vs = c.setState(setting_name: "vos", state: false)
//        ret = c.getState(setting_name: allStr)!
//        XCTAssertFalse(ret)
//
//    }
//
//    func testSelection() throws {
//        var settingsGroup = AllVerbSettingsGroup()
//        
////        for (_, grp) in settingsGroup.allGroupArray {
////            grp.print()
////        }
//        
//        let grp = settingsGroup.allGroupArray[.simple]!
//        let vs = grp.setState(setting_name: "presente", state: true)
//        grp.print()
//        vs?.print()
//        
//        let sc = settingsGroup.whereClause()
//        print("\(sc)")
//        
//        grp.setState(setting_name: "all simple tenses", state: true)
//        XCTAssert(grp.getState(setting_name: "all simple tenses") == true)
//        XCTAssert(grp.getState(setting_name: "presente") == true)
//        XCTAssert(grp.getState(setting_name: "imperfecto") == true)
//        XCTAssert(grp.getState(setting_name: "pretérito") == true)
//        XCTAssert(grp.getState(setting_name: "futuro") == true)
//        XCTAssert(grp.getState(setting_name: "condicional presente") == true)
//        XCTAssert(grp.getState(setting_name: "presente de subjuntivo") == true)
//        XCTAssert(grp.getState(setting_name: "imperfecto de subjuntivo") == true)
//        XCTAssert(grp.getState(setting_name: "imperfecto de subjuntivo (alt)") == true)
//        XCTAssert(grp.getState(setting_name: "imperativo") == true)
//
//        grp.setState(setting_name: "all simple tenses", state: false)
//        XCTAssert(grp.getState(setting_name: "all simple tenses") == false)
//        XCTAssert(grp.getState(setting_name: "presente") == false)
//        XCTAssert(grp.getState(setting_name: "imperfecto") == false)
//        XCTAssert(grp.getState(setting_name: "pretérito") == false)
//        XCTAssert(grp.getState(setting_name: "futuro") == false)
//        XCTAssert(grp.getState(setting_name: "condicional presente") == false)
//        XCTAssert(grp.getState(setting_name: "presente de subjuntivo") == false)
//        XCTAssert(grp.getState(setting_name: "imperfecto de subjuntivo") == false)
//        XCTAssert(grp.getState(setting_name: "imperfecto de subjuntivo (alt)") == false)
//
//        grp.setState(setting_name: "presente", state: true)
//        grp.setState(setting_name: "imperfecto", state: true)
//        grp.setState(setting_name: "pretérito", state: true)
//        grp.setState(setting_name: "futuro", state: true)
//        grp.setState(setting_name: "condicional presente", state: true)
//        grp.setState(setting_name: "presente de subjuntivo", state: true)
//        grp.setState(setting_name: "imperfecto de subjuntivo", state: true)
//        grp.setState(setting_name: "imperfecto de subjuntivo (alt)", state: true)
//        grp.setState(setting_name: "imperativo", state: true)
//
//        let x = grp.getState(setting_name: "all simple tenses")
//        print("\(x)")
//        XCTAssert(grp.getState(setting_name: "all simple tenses") == true)
//        
//        grp.setState(setting_name: "all simple tenses", state: true)
//        grp.setState(setting_name: "presente", state: false)
//
//        XCTAssert(grp.getState(setting_name: "all simple tenses") == false)
//        
//        grp.setState(setting_name: "presente", state: true)
//        XCTAssert(grp.getState(setting_name: "all simple tenses") == true)
//
//
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
