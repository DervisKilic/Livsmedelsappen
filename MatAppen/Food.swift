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
    var favs = [String:Any]()
    var favArray: [Dictionary<String,Any>] = []
    let defaults = UserDefaults.standard

    
    init(name: String = "", id: Int = 0, kcal: Double = 0.0,protein: Double = 0.0, fat: Double = 0.0, carbs: Double = 0.0) {
        self.name = name
        self.id = id
        self.kcal = kcal
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
    }
    func isFavorite(name: String, id: Int, kcal: Double,protein: Double, fat: Double, carbs: Double, isFav: Bool) {
        if let favorites = defaults.array(forKey: "favorites"){
            favArray = favorites as! [Dictionary<String, Any>]
        
            if isFav {

                favs = ["name":name,"id":id,"kcal":kcal,"protein":protein, "fat": fat, "carbs":carbs]
                favArray.append(favs)
                print(favArray.count) 

            } else {
            
                favArray = favArray.filter { ($0["id"] as! Int) != (id)}
                print(favArray.count)            
            
            }
            UserDefaults.standard.set(favArray, forKey: "favorites")
            UserDefaults.standard.synchronize()
        }
    }
}
