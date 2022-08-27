//
//  Orientation.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 5/6/22.
//

import Foundation
import UIKit

class Orientation: ObservableObject {
    @Published var isLandscape: Bool = UIDevice.current.orientation.isLandscape
}
