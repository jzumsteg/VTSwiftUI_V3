//
//  VerblistManagementModel.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/9/22.
//

import Foundation
import SwiftUI

class VerblistManagementModel: ObservableObject {
    @ObservedObject var environmentObjects: EnvironmentalObjects

    @Published var selectedVerblist:Verblist
    @Published var verblists = [Verblist]()
    
    init () {
        environmentObjects = EnvironmentalObjects()

        selectedVerblist = Verblist()
        verblists = environmentObjects.allVerbLists.verblists
        for vl in verblists {
            Log.print("verblist.name: \(vl.name), # inf: \(vl.infinitives.count)")
            vl.printYourself()
        }
        Log.print("selectedVerblist: \(selectedVerblist.name)")
        Log.print("verblists: \(verblists)")
    }
    
    func deleteVerblist(atOffset: IndexSet) {
        for offset in atOffset {
//            removeInfinitive(inf: verblist.infinitives[offset]
            let verblistToDelete = verblists[offset]
            verblists.remove(at: offset)
            let deleteFilePath = FileUtilities.verbListPath().stringByAppendingPathComponent(path: "\(verblistToDelete.name).verblist")
            Log.print(deleteFilePath)
            do {
                try FileManager.default.removeItem(at: URL(fileURLWithPath: deleteFilePath))
            } catch let error as NSError {
                print("Error: \(error.domain)")
            }
            
            
        }

    }
    
    func verbListExists(vlName: String) -> Bool {
        var retVal = true
        let firstPos = verblists.first { $0.name.lowercased() == vlName.lowercased() } 
        if firstPos == nil {
            retVal = false
        }
        return retVal
    }
    
    func addVerblist( verblist: Verblist) {
        verblists.append(verblist)
    }
    
}
