//
//  Food.swift
//  MatAppen
//
//  Created by Dervis Kilic on 21/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import Foundation

class Food {
    
    
    var name: String
    var id: Int
    var kcal: Double

    
    init(name: String = "", id: Int = 0, kcal: Double = 0) {
        self.name = name
        self.id = id
        self.kcal = kcal
    }
}
