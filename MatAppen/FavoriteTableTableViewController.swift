//
//  MainTableViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 21/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class FavoriteTableTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let defaults = UserDefaults.standard
        if let favs = defaults.array(forKey: "favorites"){
            
            print(favs.count)
            print(favs)
        }
        
        
        
        

          
    

        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? CustomTableViewCell {
            let detailView = segue.destination as! DetailedViewController
            
            detailView.name = cell.name.text!
            detailView.id = Int(cell.number.text!)!
            detailView.carbs = Double(cell.kcal.text!)!
            
        }
        
        
    }
    
}
