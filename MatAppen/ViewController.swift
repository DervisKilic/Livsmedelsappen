//
//  ViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 20/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var appleTree: UIImageView!
    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    let defaults = UserDefaults.standard
    var favView = false
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    
    var fallingApple: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.white.cgColor
        
        favButton.layer.cornerRadius = 5
        favButton.layer.borderWidth = 2
        favButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fallingApple = apple
        view.addSubview(fallingApple)
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [fallingApple])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fallingApple = apple
        view.addSubview(fallingApple)
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [fallingApple])
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [fallingApple])
        collision.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0.0, left: 10.0, bottom: 160.0, right: 0.0))
        animator.addBehavior(collision)
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


