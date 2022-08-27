//
//  SelectSingleVerbModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/22/22.
//

import Foundation
class SelectSingleVerbViewModel: ObservableObject {
    @Published var selectedInfinitive = String() {
        didSet {
            Log.print(selectedInfinitive)
            Params.shared.currentSelectedSingleVerbInfinitive = selectedInfinitive
        }
    }
    @Published var allInfinitives = [String]()
    @Published var selectionMode = Params.shared.verbSelectMode
    
    var infType: Infinitive_list_display = .language
    var searchStr = String()
//    var allInfinitives = [String]()
    var params = Params.shared
    
    init() {
//        if Params.shared.currentSearchStr == nil {
//            searchStr = ""
//        } else {
            searchStr = Params.shared.currentSearchStr
//        }
        getFilterdInfinitives(searchStr: searchStr)
        if params.currentSelectedSingleVerbInfinitive  != nil {
            selectedInfinitive = params.currentSelectedSingleVerbInfinitive!
        } else {
            selectedInfinitive = String()
        }
    }
    
    convenience init(searchStr: String) {
        self.init()
        getFilterdInfinitives(searchStr: searchStr)
        
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
    
}
