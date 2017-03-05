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
    
    var values: [String]
    
    init(values: [String]){
        self.values = values
    }
    
    public func numberOfBars() -> Int {
        return 3
    }
    
    public func valueForBar(at index: Int) -> NSNumber! {
        
        return [Double(self.values[1]), Double(self.values[2]), Double(self.values[3])][index] as NSNumber!
    }
    
    public func colorForBar(at index: Int) -> UIColor! {
        
        return [UIColor.gk_carrot(), UIColor.gk_amethyst(), UIColor.gk_emerland()][index]
        
    }
    
    public func animationDurationForBar(at index: Int) -> CFTimeInterval {
        return 1.0
    }
    
    public func titleForBar(at index: Int) -> String! {
        
        return ["carbs", "fat", "prot"][index]
    }
}
