//
//  Array_ext.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 4/16/22.
//

import Foundation
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
    // for info in the use of the partially/relaxed/etc extensions below, look at: https://medium.com/nerd-for-tech/make-swift-contains-and-filter-ready-for-ios-development-e60a6570f5a2
    func partiallyContains(check: Element) -> Bool where Element ==
    String {
      for str in self {
        if str.contains(check) {
          return true
        }
      }
      return false
    }
    func partiallyContainsFilter(word: Element) -> [Element] where
    Element == String {
      self.filter({$0.contains(word)})
   }
    
    func relaxedOrderElementsEqual(with array: [Element]) -> Bool
    where Element == String {
      var result = true
      for i in array {
         if !self.contains(i) {
           result = false
           return result
        }
      }
      return result
    }
    func relaxedOrderContains(word: Element) -> Bool where Element ==
    String {
      let arrayToBeChecked = word.components(separatedBy: " ")
      var res = false
      for i in self {
        let currentArrayToBeChecked = i.components(separatedBy: " ")
        if arrayToBeChecked.relaxedOrderElementsEqual(with:
         currentArrayToBeChecked) {
          res = true
          return res
        }
      }
      return res
    }
    func relaxedOrderFilter(word: Element) -> [Element] where Element
    == String {
      let arrayToBeChecked = word.components(separatedBy: " ")
      return self.filter { i in
          let wordtobechecked = i.components(separatedBy: " ")
          return wordtobechecked.relaxedOrderElementsEqual(with:
                 arrayToBeChecked)
          }
     }
    func flexibleElementsEqual(with array: [Element]) -> Bool where
    Element == String {
      var result = true
      for i in array {
        if !self.partiallyContains(check: i) {
          result = false
          return result
       }
     }
     return result
   }
   func flexibleFilter(word: Element) -> [Element] where Element ==
    String {
     let arrayToBeChecked = word.components(separatedBy: " ")
     return self.filter { i in
         let wordtobechecked = i.components(separatedBy: " ")
         return wordtobechecked.flexibleElementsEqual(with:
                arrayToBeChecked)
         }
   }
}
