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
    var protein: Double
    var fat: Double
    var carbs: Double

    
    init(name: String = "", id: Int = 0, kcal: Double = 0.0,protein: Double = 0.0, fat: Double = 0.0, carbs: Double = 0.0) {
        self.name = name
        self.id = id
        self.kcal = kcal
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
    }
}
