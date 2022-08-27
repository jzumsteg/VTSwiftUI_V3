//
//  VerbLists.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/7/22.
//

import Foundation
class Verblists: ObservableObject {
    @Published var verblists = [Verblist]()
    var verblistNames = [String]()
    
    init()  {
        populateVerblists()
    }
    
    func populateVerblists() {
        
        let urls = populateVerblistURLs()
        for url in urls {
            let vl = Verblist()
            vl.retrieveLocally(url: url)
            vl.isDirty = false
            vl.isNew = false
            verblists.append(vl)
            verblistNames.append(vl.name.lowercased())
        }
        verblists.sort {$0.name < $1.name}
    }
    
    func populateVerblistURLs() -> [URL] {
        var verblistURLs = [URL]()  // create an empty arry ofverblists
        FileUtilities.createVerbListDirectory()
        let verbListURL = URL(fileURLWithPath: FileUtilities.verbListPath())
        
        // now read all files with a tpe of .swift
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: verbListURL, includingPropertiesForKeys: nil)
            //            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            verblistURLs = directoryContents.filter{ $0.pathExtension == "verblist" }
            for url in verblistURLs {
                Log.print(url.path)
            }
            
        } catch {
            Log.print("\(error)")
        }
        
        
        return verblistURLs
    }
    
    func verbListExists(vlName: String) -> Bool {
        var retVal = true
        let firstPos = verblists.first { $0.name == vlName }
        if firstPos == nil {
            retVal = false
        }
        return retVal
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
        
        verblists.removeAll()
        populateVerblists()
        verblists.sort {$0.name < $1.name}

    }
}
