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
    
    
    
    @IBOutlet weak var graphView: UIView!
    
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
        
        graph = GKBarGraph(frame: CGRect(x: view.center.x, y:view.frame.height/2 , width: view.frame.minX, height: view.frame.minY))
        graph.dataSource = g1
        
        graph.barWidth = 60
       
        graph2 = GKBarGraph(frame: CGRect(x: view.center.x, y:view.frame.height/1.1 , width: view.frame.minX, height: view.frame.minY))
        graph2.dataSource = g2
        
        graph2.barWidth = 60
        
        
        view.addSubview(graph)
        view.addSubview(graph2)
        
        graph.draw()
        graph2.draw()

    }
}
