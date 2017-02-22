//
//  ViewController.swift
//  MatAppen
//
//  Created by Dervis Kilic on 20/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    @IBOutlet weak var search: UISearchBar!
    
    var searchController : UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        definesPresentationContext = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        search = searchController.searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text?.lowercased() {
            
            if searchText.characters.count > 2 {
                
            }
        }
    }
}


