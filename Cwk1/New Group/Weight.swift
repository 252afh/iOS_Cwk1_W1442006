//
//  Weight.swift
//  Cwk1
//
//  Created by user149138 on 3/6/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation

struct Weight : Codable {
    // Struct for Weight information
    var kilograms:String
    var grams:String
    var ounces:String
    var pounds:String
    var stonePounds:String
    
    init(kilograms:String, grams:String, ounces:String, pounds:String, stonePounds:String) {
        self.kilograms = kilograms
        self.grams = grams
        self.ounces = ounces
        self.pounds = pounds
        self.stonePounds = stonePounds
    }
}
