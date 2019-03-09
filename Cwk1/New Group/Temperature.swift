//
//  Temperature.swift
//  Cwk1
//
//  Created by user149138 on 3/6/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation

struct Temperature : Codable {
    // Struct for Temperature information
    var celsius:String
    var fahrenheit:String
    var kelvin:String
    
    init(celsius:String, fahrenheit:String, kelvin:String) {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
    }
}
