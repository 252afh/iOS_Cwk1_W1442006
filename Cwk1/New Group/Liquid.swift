//
//  Liquid.swift
//  Cwk1
//
//  Created by user149138 on 3/6/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation

struct Liquid : Codable {
    // Struct for Liquid information
    var gallons:String
    var litres:String
    var pints:String
    var ounces:String
    var millilitres:String
    
    init(gallons:String, litres:String, pints:String, ounces:String, millilitres:String) {
        self.gallons = gallons
        self.litres = litres
        self.pints = pints
        self.ounces = ounces
        self.millilitres = millilitres
    }
}
