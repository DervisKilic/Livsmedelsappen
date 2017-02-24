//
//  detailedViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 22/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var switchState: UISwitch!
    
    
    var name : String = ""
    var id : Int = 0
    var carbs : Double = 0.0
    var fat : Double = 0.0
    var protein : Double = 0.0
    let p1 = ParseHelper()
    let f1 = Food()
    var data: [Food] = []
    var favs: [Double] = []
    var kcal : Double = 0.0
    let defaults = UserDefaults.standard
    var comingFromFavorite = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchRead = defaults.bool(forKey: id.description)
        
        if switchRead || comingFromFavorite {
        switchState.isOn = true
        }
    
    
        nameLabel.text = name
        
        if !comingFromFavorite {
            
            self.p1.parseJsonNut(id: self.id) {
                self.data = $0
                for food in self.data {
                    self.carbsLabel.text = String(food.carbs)
                    self.proteinLabel.text = String(food.protein)
                    self.fatLabel.text = String(food.fat)
                    self.carbs = food.carbs
                    self.protein = food.protein
                    self.fat = food.fat
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func favorite(_ sender: UISwitch) {
        
        
        if sender.isOn{
            switchState.isOn = true
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: true)
            
            
            
            UserDefaults.standard.set(switchState.isOn, forKey: id.description)
            UserDefaults.standard.synchronize()
            
            
        }else{
            switchState.isOn = false
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: false)
            
            UserDefaults.standard.set(switchState.isOn, forKey: id.description)
            UserDefaults.standard.synchronize()
        }
       
    }
}
