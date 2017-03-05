//
//  MainTableViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 21/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController : UISearchController!
    
    var p1 = ParseHelper()
    var id = 0
    var kcal = 0
    var carbs : Double = 0.0
    var fat : Double = 0.0
    var protein : Double = 0.0
    var compare = false
    var name = ""
    var showFavView = false
    let defaults = UserDefaults.standard
    var favData = [String: Any]()
    var data: [Food] = []
    var healthiness: Double = 0.0
    var loadValues = false
    var favFood : [Food] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFavView = defaults.bool(forKey: "favView")
        
        if !showFavView{
        definesPresentationContext = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 0.29, green: 0.384, blue: 0.278, alpha: 1.0)
        searchController.searchBar.tintColor = UIColor.white
        }
        tableView.backgroundColor = UIColor(red: 0.29, green: 0.384, blue: 0.278, alpha: 1.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func updateSearchResults(for searchController: UISearchController) {

        if let searchText = searchController.searchBar.text?.lowercased() {
            if searchText.characters.count > 2 {
            data = data.filter { $0.name.lowercased().contains(searchText) }
                p1.parseJson(searchWord: searchText) {
                    self.data = $0
                    for food in self.data {
                        self.id = food.id
                        self.name = food.name
                        self.p1.parseJsonNut(id: food.id) {
                            food.kcal = $0[0].kcal
                            food.protein = $0[0].protein
                            food.fat = $0[0].fat
                            food.carbs = $0[0].carbs
                            food.healthiness = $0[0].healthiness
                            
                            self.kcal = food.kcal
                            self.carbs = food.carbs
                            self.fat = food.fat
                            self.protein = food.protein
                            self.healthiness = food.healthiness
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        } else {
            data = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        if showFavView {
            return false
        } else {
            return searchController.isActive && !(searchController.searchBar.text ?? "").isEmpty
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        
        if showFavView{
            if let count = defaults.array(forKey: "favorites")?.count{
                return count
            }else{
                return 0
            }
            
        }else{
            return data.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        if shouldUseSearchResult {

            cell.name.text = data[indexPath.row].name
            cell.kcal.text = String("\(data[indexPath.row].kcal) kcal")
            
        } else if showFavView {
            
            if let favs = defaults.array(forKey: "favorites"){
                
                favData = favs[indexPath.row] as! Dictionary<String,Any>
                name = (favData["name"] as! String)
                id = (favData["id"] as! Int)
                kcal = favData["kcal"] as! Int
                carbs = favData["carbs"] as! Double
                fat = favData["fat"] as! Double
                protein = favData["protein"] as! Double
                healthiness = favData["healthiness"] as! Double
                cell.name.text = name
                cell.kcal.text = String("\(kcal) kcal")
                favFood.append(Food(name: name, id: id, kcal: kcal, protein: protein, fat: fat, carbs: carbs, healthiness: healthiness))
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        if showFavView{
            name = favFood[indexPath.row].name
            id = favFood[indexPath.row].id
            kcal = favFood[indexPath.row].kcal
            carbs = favFood[indexPath.row].carbs
            fat = favFood[indexPath.row].fat
            protein = favFood[indexPath.row].protein
            healthiness = favFood[indexPath.row].healthiness
            loadValues = true
            performSegue(withIdentifier: "detail", sender: nil)
            
        } else {
            name = data[indexPath.row].name
            id = data[indexPath.row].id
            kcal = data[indexPath.row].kcal
            carbs = data[indexPath.row].carbs
            fat = data[indexPath.row].fat
            protein = data[indexPath.row].protein
            healthiness = data[indexPath.row].healthiness
            performSegue(withIdentifier: "detail", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailView = segue.destination as! DetailedViewController
            detailView.name = name
            detailView.id = id
            detailView.kcal = kcal
            detailView.carbs = carbs
            detailView.fat = fat
            detailView.protein = protein
            detailView.healthiness = healthiness
            favFood = []
            loadValues = false
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String,sender: Any?) -> Bool {
        
        if !loadValues{
            return false
        }
        return true
    }
}
