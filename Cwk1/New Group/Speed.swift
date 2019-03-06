//
//  Speed.swift
//  Cwk1
//
//  Created by user149138 on 3/6/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation

struct Speed : Codable {
    var ms:String
    var kmh:String
    var mph:String
    var knots:String
    
    init(ms:String, kmh:String, mph:String, knots:String) {
        self.ms = ms
        self.kmh = kmh
        self.mph = mph
        self.knots = knots
    }
}
