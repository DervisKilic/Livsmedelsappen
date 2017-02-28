//
//  GraphHelper.swift
//  MatAppen
//
//  Created by Dervis Kilic on 28/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import Foundation
import GraphKit

class GraphHelper: NSObject, GKBarGraphDataSource {
    
    var carbs : Double
    var fat : Double
    var prot : Double
    
    
    
    init(carbs: String, fat: String, prot: String){
        self.carbs = Double(carbs)!
        self.fat = Double(fat)!
        self.prot = Double(prot)!
    }
    
    
    public func numberOfBars() -> Int {
        return 3
    }
    
    public func valueForBar(at index: Int) -> NSNumber! {
        let values = [self.carbs, self.fat, self.prot]
        
        return values[index] as NSNumber!
    }
    
    public func colorForBar(at index: Int) -> UIColor! {
        let colors = [UIColor.gk_carrot(), UIColor.gk_amethyst(), UIColor.gk_emerland()]
        
        return colors[index]
        
    }
    
    public func animationDurationForBar(at index: Int) -> CFTimeInterval {
        return 1.0
    }
    
    public func titleForBar(at index: Int) -> String! {
        let names = ["carbs", "fat", "prot"]

        return names[index]
    }
}
