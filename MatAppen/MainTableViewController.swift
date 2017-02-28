//
//  MainTableViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 21/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    
    var p1 = ParseHelper()
    var compare = false
    
    var data: [Food] = []    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        definesPresentationContext = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {

        if let searchText = searchController.searchBar.text?.lowercased() {
            
            if searchText.characters.count > 2 {
            data = data.filter { $0.name.lowercased().contains(searchText) }
                p1.parseJson(searchWord: searchText) {
                    self.data = $0
                    for food in self.data {
                        self.p1.parseJsonKcal(id: food.id) {
                            food.kcal = $0
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

        return searchController.isActive && !(searchController.searchBar.text ?? "").isEmpty
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if shouldUseSearchResult {
            return data.count
        } else {
            return data.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        if shouldUseSearchResult {

            cell.name.text = data[indexPath.row].name
            cell.number.text = String(data[indexPath.row].id)
            cell.kcal.text = String(data[indexPath.row].kcal)
            
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
            detailView.kcal = Double(cell.kcal.text!)!
        }

        
    }

}
