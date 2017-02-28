//
//  detailedViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 22/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {    

    @IBOutlet weak var batImage1: UIImageView!
    @IBOutlet weak var batImage2: UIImageView!
    @IBOutlet weak var batImage3: UIImageView!
    @IBOutlet weak var batImage4: UIImageView!
    @IBOutlet weak var batImage5: UIImageView!
    @IBOutlet weak var bat1: NSLayoutConstraint!
    @IBOutlet weak var bat2: NSLayoutConstraint!
    @IBOutlet weak var bat3: NSLayoutConstraint!
    @IBOutlet weak var bat4: NSLayoutConstraint!
    @IBOutlet weak var bat5: NSLayoutConstraint!
    @IBOutlet weak var compareButton: UIButton!
    
    
    
    @IBOutlet weak var foodImage: UIImageView!
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
    var compare = false
    var comingFromFavorite = false
    var switchRead = false
    var runOnce = true
    
    var imagePath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first{
            return documentsDirectory.appending("/\(id.description).png")
        }else {
            fatalError("Found no documents directory")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bat1.constant -= view.bounds.height
        bat2.constant -= view.bounds.height
        bat3.constant -= view.bounds.height
        bat4.constant -= view.bounds.height
        bat5.constant -= view.bounds.height



    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let batmen = [bat1, bat2, bat3, bat4, bat5]
        
        for (index,batman) in batmen.enumerated() {
            let d = 1.0 + Double(index)
            UIView.animate(withDuration: d, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                batman!.constant += self.view.bounds.height
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(switchRead, forKey: id.description)
        UserDefaults.standard.synchronize()
        
    }
    
    @IBAction func favorite(_ sender: UISwitch) {
        
        if sender.isOn{
            switchState.isOn = true
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: true)
            
            if !runOnce{
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: true)
                runOnce = true
                UserDefaults.standard.set(runOnce, forKey: "run")
                UserDefaults.standard.synchronize()
            }

            switchRead = true
        }else{
            
            switchState.isOn = false
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: false)
            
            switchRead = false
        }
        
        UserDefaults.standard.set(switchRead, forKey: id.description)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
        }
        else{
            fatalError("No type")
        }
        
        present(picker,animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        if let data = UIImagePNGRepresentation(image){
            do{
                let url = URL(fileURLWithPath: imagePath)
                try data.write(to: url)
                NSLog("Done image data to file \(imagePath)")
            }
            catch let error{
                NSLog("Failed to save image: \(error)")
            }
        }
        
        foodImage.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func setData(){
        compare = defaults.bool(forKey: "compare")
        nameLabel.text = name
        runOnce = defaults.bool(forKey: "run")
        if let image = UIImage(contentsOfFile: imagePath){
            foodImage.image = image
        }else {
            NSLog("Failed to load image from imagepath: \(imagePath)")
        }
        
            self.p1.parseJsonNut(id: self.id) {
                self.data = $0
                for food in self.data {
                    self.carbsLabel.text = "Kolhydrater: \(String(food.carbs))"
                    self.proteinLabel.text = "Protein: \(String(food.protein))"
                    self.fatLabel.text = "Fett: \(String(food.fat))"
                    self.setHealth(healthiness: food.healthiness)
                    self.carbs = food.carbs
                    self.fat = food.fat
                    self.protein = food.protein
                }
            }
        switchRead = defaults.bool(forKey: id.description)
        
        if switchRead || comingFromFavorite {
            switchState.isOn = true
            
        }
    }
    func setHealth(healthiness: Double){
        print(healthiness)
        print(healthiness)

        print(healthiness)

        print(healthiness)

        print(healthiness)

        
        switch healthiness {
        case 0...20:
            batImage1.isHidden = false
        case 0...100:
            batImage1.isHidden = false
            batImage2.isHidden = false
        case 0...200:
            batImage1.isHidden = false
            batImage2.isHidden = false
            batImage3.isHidden = false
        case 0...300:
            batImage1.isHidden = false
            batImage2.isHidden = false
            batImage3.isHidden = false
            batImage4.isHidden = false
        case 0...9999:
            batImage1.isHidden = false
            batImage2.isHidden = false
            batImage3.isHidden = false
            batImage4.isHidden = false
            batImage5.isHidden = false

        default:
            batImage1.isHidden = false
            
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "s1" {
                if segue.destination is MainTableViewController {
                    
                    let savedValues1 = [name,String(carbs),String(fat),String(protein)]
                    UserDefaults.standard.set(savedValues1, forKey: "values1")
                    UserDefaults.standard.synchronize()
                }
            }
            else if segue.identifier == "s2" {
                
                if let graphView = segue.destination as? GraphViewController {
                    let savedValues2 = [name,String(carbs),String(fat),String(protein)]
                    
                    UserDefaults.standard.set(savedValues2, forKey: "values2")
                    UserDefaults.standard.synchronize()

                    graphView.values1 = defaults.array(forKey: "values1") as! [String]
                    graphView.values2 = defaults.array(forKey: "values2") as! [String]
            }
        }
    }
    @IBAction func compareButton(_ sender: UIButton) {
        
        if !compare{
            performSegue(withIdentifier: "s1", sender: nil)
            compareButton.setTitle("Compare with this", for: .normal)
            compare = true
            UserDefaults.standard.set(compare, forKey: "compare")
            UserDefaults.standard.synchronize()

        }else{
            performSegue(withIdentifier: "s2", sender: nil)
            compareButton.setTitle("Compare", for: .normal)
            compare = false
            UserDefaults.standard.set(compare, forKey: "compare")
            UserDefaults.standard.synchronize()

        }
    }
}
