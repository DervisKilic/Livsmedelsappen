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
    
    
    var ImagePath : String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        
        return documentDirectory.appending("/chached.png")
        
    }
    
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
        

        if let image = UIImage(contentsOfFile: ImagePath){
            
            foodImage.image = image
            
        }else{
            NSLog("Failed to to load from: \(ImagePath)")
        }
        
        
        
        
        let switchRead = defaults.bool(forKey: id.description)

        if switchRead || comingFromFavorite {
        switchState.isOn = true
            
        }
    
    
        nameLabel.text = name
        
        if !comingFromFavorite {
            getValues()
        }
    }
    
    func getValues(){
        
        self.p1.parseJsonNut(id: self.id) {
            self.data = $0
            for food in self.data {
                self.carbsLabel.text = String(food.carbs)
                self.proteinLabel.text = String(food.protein)
                self.fatLabel.text = String(food.fat)
                
            }
        }
    }

    @IBAction func favorite(_ sender: UISwitch) {
        if sender.isOn{
            switchState.isOn = true
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: true)
            
        }else{
            
            switchState.isOn = false
            
            self.f1.isFavorite(name: self.name, id: self.id, kcal: self.kcal, protein: self.protein, fat: self.fat, carbs: self.carbs, isFav: false)
        
        }
     
        UserDefaults.standard.set(switchState.isOn, forKey: id.description)
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
                let url = URL(fileURLWithPath: ImagePath)
                try data.write(to: url)
                NSLog("Done image data to file \(ImagePath)")
            }
            catch let error{
                NSLog("Failed to save image: \(error)")
            }
        }
        
        
        foodImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
}
