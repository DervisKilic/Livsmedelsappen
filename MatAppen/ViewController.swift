//
//  ViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 20/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let defaults = UserDefaults.standard
    var favView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToFavsView(_ sender: UIButton) {
        favView = true
        
        UserDefaults.standard.set(favView, forKey: "favView")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func goToSearchView(_ sender: UIButton) {
        favView = false
        
        UserDefaults.standard.set(favView, forKey: "favView")
        UserDefaults.standard.synchronize()
        
    }
}


