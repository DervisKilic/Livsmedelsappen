//
//  detailedViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 22/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
    var comingFromFavorite = false
    var switchRead = false
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(switchRead, forKey: id.description)
        UserDefaults.standard.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func favorite(_ sender: UISwitch) {
        if sender.isOn{
            switchState.isOn = true
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: true)
            
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
        if let image = UIImage(contentsOfFile: imagePath){
            foodImage.image = image
        }else {
            NSLog("Failed to load image from imagepath: \(imagePath)")
        }
        
        nameLabel.text = name
        
        if !comingFromFavorite {
            self.p1.parseJsonNut(id: self.id) {
                self.data = $0
                for food in self.data {
                    self.carbsLabel.text = String(food.carbs)
                    self.proteinLabel.text = String(food.protein)
                    self.fatLabel.text = String(food.fat)
                }
            }
        }
        
        switchRead = defaults.bool(forKey: id.description)
        
        if switchRead || comingFromFavorite {
            switchState.isOn = true
            
        }
    }
}
