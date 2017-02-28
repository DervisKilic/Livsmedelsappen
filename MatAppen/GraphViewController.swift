//
//  ViewController.swift
//  AutoLayout
//
//  Created by Dervis Kilic on 15/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit
import GraphKit

class GraphViewController: UIViewController {
    
    var name = ""
    var carbs = 0.0
    var fat = 0.0
    var prot = 0.0
    var carbs2 = 0.0
    var fat2 = 0.0
    var prot2 = 0.0
    
    var graph : GKBarGraph!
    var graph2 : GKBarGraph!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let g1 = GraphHelper(carbs: carbs, fat: fat, prot: prot)
        let g2 = GraphHelper(carbs: carbs2, fat: fat2, prot: prot2)
        
        graph = GKBarGraph(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        graph .dataSource = g1
        
        graph.barWidth = 60
        
        graph2 = GKBarGraph(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: 300))
        graph2 .dataSource = g2
        
        graph2 .barWidth = 60
        
        
        view.addSubview(graph)
        view.addSubview(graph2)
        
        graph.draw()
        graph2.draw()

    }
}
