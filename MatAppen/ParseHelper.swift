//
//  ParseHelper.swift
//  MatAppen
//
//  Created by Dervis Kilic on 20/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import Foundation

class ParseHelper {
    
    var id = 0

    func parseJson(searchWord: String, tableViewController: MainTableViewController) {
        
        let urlString = "http://www.matapi.se/foodstuff?query=\(searchWord)"
        
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [[String:Any]] {
                            
                            var foods : [Food] = []

                            for item in parsed {
                                let id = item["number"] as! Int
                                let name = item["name"] as! String


                                foods.append(Food(name: name, id: id))                                
                            }
                            tableViewController.data = foods
                            tableViewController.tableView.reloadData()
                            
                        } else {
                            NSLog("Failed to cast from json.")
                        }
                    }
                    catch let parseError {
                        NSLog("Failed to parse json: \(parseError)")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
            
        } else {
            NSLog("Failed to create url.")
        }
        
    }
    
    func parseJsonKcal(id: Int){
        
        let urlString = "http://www.matapi.se/foodstuff/\(id)?nutrient="
        
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [[String:Any]] {
                            
                            
                            
                            for item in parsed {
                                
                                let kcal = item["energyKcal"] as! Double
                            }
                        
                        
                        } else {
                            NSLog("Failed to cast from json.")
                        }
                    }
                    catch let parseError {
                        NSLog("Failed to parse json: \(parseError)")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
            
            
        } else {
            NSLog("Failed to create url.")
        }
    }
}
