//
//  detailedViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 22/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var app1: UIImageView!
    @IBOutlet weak var app2: UIImageView!
    @IBOutlet weak var app3: UIImageView!
    @IBOutlet weak var app4: UIImageView!
    @IBOutlet weak var app5: UIImageView!
    @IBOutlet weak var apple5: NSLayoutConstraint!
    @IBOutlet weak var apple4: NSLayoutConstraint!
    @IBOutlet weak var apple3: NSLayoutConstraint!
    @IBOutlet weak var apple2: NSLayoutConstraint!
    @IBOutlet weak var apple1: NSLayoutConstraint!
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
    var kcal : Int = 0
    var healthiness: Double = 0.0
    let defaults = UserDefaults.standard
    var compare = false
    var runOnce = true
    var test = UIView()
    
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
        compareButton.layer.cornerRadius = 5
        compareButton.layer.borderWidth = 2
        compareButton.layer.borderColor = UIColor.white.cgColor
        switchState.onTintColor = UIColor(red: 0.56, green: 0.71, blue: 0.54, alpha: 1.0)
        setData()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        apple1.constant -= view.bounds.height
        apple2.constant -= view.bounds.height
        apple3.constant -= view.bounds.height
        apple4.constant -= view.bounds.height
        apple5.constant -= view.bounds.height
        
        switch healthiness {
        case 50...150:
            
            app3.isHidden = true
            app4.isHidden = true
            app5.isHidden = true
            
        case 50...300:
            app4.isHidden = true
            app5.isHidden = true
            
        case 50...500:
           app5.isHidden = true
            
        case 50...9999:
            app5.isHidden = false

        default:
            app2.isHidden = true
            app3.isHidden = true
            app4.isHidden = true
            app5.isHidden = true
        }
        
        super.viewWillAppear(animated)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let apples = [apple1, apple2, apple3, apple4, apple5]
        
        for (index,appl) in apples.enumerated() {
            let d = 0.5 + Double(index)
            UIView.animate(withDuration: d, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                appl!.constant += self.view.bounds.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @IBAction func favorite(_ sender: UISwitch) {
        
        if sender.isOn{
            switchState.isOn = true
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, healthiness: self.healthiness, isFav: true)
            
            if !runOnce{
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, healthiness: self.healthiness, isFav: true)
                runOnce = true
                UserDefaults.standard.set(runOnce, forKey: "run")
                UserDefaults.standard.synchronize()
            }
            
        }else{
            switchState.isOn = false
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, healthiness: self.healthiness, isFav: false)
        }
        UserDefaults.standard.set(switchState.isOn, forKey: id.description)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func addImg(_ sender: Any) {
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
            //NSLog("Failed to load image from imagepath: \(imagePath)")
        }
        self.carbsLabel.text = "\(carbs)"
        self.proteinLabel.text = "\(protein)"
        self.fatLabel.text = "\(fat)"

        switchState.isOn = defaults.bool(forKey: id.description)
        
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
            compare = true
            UserDefaults.standard.set(compare, forKey: "compare")
            UserDefaults.standard.synchronize()

        }else{
            performSegue(withIdentifier: "s2", sender: nil)
            compare = false
            UserDefaults.standard.set(compare, forKey: "compare")
            UserDefaults.standard.synchronize()
        }
    }
}
