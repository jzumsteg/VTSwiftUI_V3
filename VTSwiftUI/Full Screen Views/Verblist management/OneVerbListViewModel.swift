//
//  OneVerbListViewModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/16/22.
//

import Foundation
import SwiftUI

enum errors {
    case verbLisExists
    case noVerbListName
    case noInfinitives
    case nameIsBlank
    
}
class OneVerbListViewModel: ObservableObject {
    @ObservedObject var environmentObjects: EnvironmentalObjects
    @Published var allInfinitives = [String]()
    @Published var verbListInfinitives = [String]()
    @Published var verblist = Verblist() {
        didSet {
            Log.print("verblist didSet to \(verblist)")
        }
    }
    @Published var verbListName: String? {
        didSet {
            Log.print("verbListName: \(verbListName ?? "no verblist name in verbListName didSet")")
        }
    }
    @Published var verblists: [Verblist]?
    
    var infType: Infinitive_list_display = .language
    
    var originalVerbList: Verblist = Verblist()
    
    init() {
        environmentObjects = EnvironmentalObjects()
        getAllInfinitives()
        getVerblistInfinitives()
        verbListName = ""
    }
    
    convenience init(vl: Verblist) {
        self.init()
        verblist = vl
    }
    
    func setup(verbListName: String, environmentObjects: EnvironmentalObjects) {
        self.environmentObjects = environmentObjects
        self.verblist.name = verbListName
        self.verbListName = verbListName
        if self.verbListName == "" {
            self.verblist = Verblist()
//            self.originalVerbList.name = ""
            originalVerbList = Verblist()
        }
        else {
            self.verblist.retrieveLocally()
            originalVerbList.name = verbListName
            originalVerbList.retrieveLocally()
        }

    }
    
    func isValidForSave() -> Bool {
        if verblist.name != "" && verblist.infinitives.count > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func getFilterdInfinitives( searchStr: String) {
        getAllInfinitives()
        var subset = allInfinitives
        if searchStr.isEmpty == false {
            subset = allInfinitives.filter { $0.hasPrefix(searchStr) }
            allInfinitives = subset
            }
    }
    
    func getAllInfinitives() {
        switch infType {
        case .language:
            allInfinitives = Infinitives.getLanguageInfinitivesOnly()
        case .english:
            allInfinitives = Infinitives.getEnglishInfinitivesIntoArray()
        }
//        allInfinitives = Infinitives.getLanguageInfinitivesOnly()
        allInfinitives = allInfinitives.sorted()
    }
    
    func getVerblistInfinitives(){
        verbListInfinitives = verblist.infinitives.sorted()
//        return verbListInfinitives
        
    }
    
    func addInfinitive(inf: String) {
        // need to get the language infinitive only before we add or remvoe
        verblist.isDirty = true
        let infOnly = Infinitives.theInfinitive(textStr: inf, language: infType)
        if verblist.infinitives.contains(infOnly) == false {
            verblist.infinitives.append(infOnly)
            verblist.infinitives = verblist.infinitives.sorted()
            getVerblistInfinitives()
        }
    }
    
    func removeInfinitive(inf: String) {
        verblist.isDirty = true
        let infOnly = inf
        if let index = verblist.infinitives.firstIndex(of: infOnly) {
            verblist.infinitives.remove(at: index)
            verblist.infinitives = verblist.infinitives.sorted()
//            verblist.save()
            getVerblistInfinitives()
        }
    }
    
    func deleteInfinitive(atOffset: IndexSet ) {
        Log.print("deleting \(atOffset.count)")
        for offset in atOffset {
            removeInfinitive(inf: verblist.infinitives[offset])
        }
        verblist.isDirty = true
//        verblist.save()
//        getVerblistInfinitives()
    }
    
    func revertToOriginal() {
        verblist = originalVerbList.copy()
    }
    
    func isNameChanged() -> Bool {
        Log.print("verblist.name: \(verblist.name), originalVerbList.name: \(originalVerbList.name)")
        if verblist.name.trimmingCharacters(in: .whitespacesAndNewlines) != originalVerbList.name.trimmingCharacters(in: .whitespacesAndNewlines) {
            return true
        }
        else {
            return false
        }
    }
    
    func isNameUnique() -> Bool {
        for vl in environmentObjects.allVerbLists.verblists {
            Log.print("\(vl.name)")
            if vl.name == verblist.name {
                return false
            }
        }
        return true

    }
    
    
    func isNameDuplicated() -> Bool {
        if environmentObjects.allVerbLists.verblistNames.contains(verblist.name) {
            return true
        }
        else {
            return false
        }
    }
    
    func infinitivesChanged() -> Bool {
        let originalSet = originalVerbList.infinitives
        let workingSet = verblist.infinitives
        let difference = originalSet.difference(from: workingSet)
        return difference.count == 0 ? false : true
        
        
    }
    
    func saveVerblist() {
        Log.print("Save verblist \(verblist.name)")
        verblist.name = verblist.name.trimmingCharacters(in: .whitespacesAndNewlines)
        verblist.printYourself()
        if verblist.name == "" || verblist.infinitives.count == 0 {
            Log.print("Cannot save this verblist \(verblist.name)")
        } else {
            Log.print("Saving the verblist \(verblist.name)")
            if verblist.isNew == true {
                environmentObjects.allVerbLists.verblists.append(verblist)
            }
            verblist.save()
            verblist.isDirty = false
            originalVerbList = verblist.copy()
        }
        environmentObjects.updateVerblists()
        environmentObjects.allVerbLists.verblists.sort {$0.name < $1.name}
        environmentObjects.redrawVerblists = true
    }
    
}
