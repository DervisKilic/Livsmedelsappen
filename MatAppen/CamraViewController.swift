//
//  ViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 20/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class CamraViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let image = UIImage(contentsOfFile: ImagePath){
            imageView.image = image
        }else{
            NSLog("Failed to to load from: \(ImagePath)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func takepic(_ sender: Any) {
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
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    var ImagePath : String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        
        return documentDirectory.appending("/chached.png")
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


