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
    @IBOutlet weak var name1Label: UILabel!
    
    @IBOutlet weak var name2Label: UILabel!
    var name = ""
    var name2 = ""

    var values1: [String] = []
    var values2: [String] = []
    
    var graph : GKBarGraph!
    var graph2 : GKBarGraph!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name1Label.text = values1[0]
        name2Label.text = values2[0]
        
        let g1 = GraphHelper(values: values1)
        let g2 = GraphHelper(values: values2)
        
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
