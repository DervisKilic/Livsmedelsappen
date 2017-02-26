//
//  MainTableViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 21/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class FavoriteTableTableViewController: UITableViewController {

    
    var data = [String: Any]()
    var id = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        
        let defaults = UserDefaults.standard
        if let favs = defaults.array(forKey: "favorites"){
            return favs.count
        }else{
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let defaults = UserDefaults.standard
        if let favs = defaults.array(forKey: "favorites"){
            

            data = favs[indexPath.row] as! Dictionary<String,Any>
            cell.name.text = (data["name"] as! String)
            cell.kcal.text = String(data["kcal"] as! Double)
            cell.number.text = String(data["id"] as! Int)
            id = cell.number.text!
            print(id)
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? CustomTableViewCell {
            let detailView = segue.destination as! DetailedViewController
            
            detailView.name = cell.name.text!
            detailView.comingFromFavorite = true
            detailView.id = Int(cell.number.text!)!
            detailView.kcal = Double(cell.kcal.text!)!
        }
        
        
    }
    
}
