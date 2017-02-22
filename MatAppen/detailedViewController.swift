//
//  detailedViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 22/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class detailedViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    var label : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = label

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
