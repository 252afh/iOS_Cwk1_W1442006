//
//  Length.swift
//  Cwk1
//
//  Created by user149138 on 3/6/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation

struct Length : Codable {
    var metres:String
    var miles:String
    var centimetres:String
    var millimetres:String
    var yards:String
    var inches:String
    
    init(metres:String, miles:String, centimetres:String, millimetres:String, yards:String, inches:String) {
        self.metres = metres
        self.miles = miles
        self.centimetres = centimetres
        self.millimetres = millimetres
        self.yards = yards
        self.inches = inches
    }
}
