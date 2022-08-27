//
//  Double_ext.swift
//  HistReg
//
//  Created by John Zumsteg on 1/18/21.
//  Copyright © 2021 John Zumsteg. All rights reserved.
//

import Foundation
extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
