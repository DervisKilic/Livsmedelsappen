//
//  ParseHelper.swift
//  MatAppen
//
//  Created by Dervis Kilic on 20/02/17.
//  Copyright © 2017 Dervis Kilic. All rights reserved.
//

import Foundation

class ParseHelper {

    func parseJson(searchWord: String, data: @escaping ([Food]) -> Void){
        
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
                            DispatchQueue.main.async {
                            var foods : [Food] = []

                            for item in parsed {
                                let id = item["number"] as! Int
                                let name = item["name"] as! String

                                foods.append(Food(name: name, id: id))

                            }
                            data(foods)
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
    
    func parseJsonKcal(id: Int, data: @escaping (Double) -> Void){
        
        let urlString = "http://www.matapi.se/foodstuff/\(id)"
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            
                            DispatchQueue.main.async {
                            let item = parsed["nutrientValues"] as! [String:Any]
                            let kcal = item["energyKcal"] as! Double
                           
                            data(kcal)

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
    
    func parseJsonNut(id: Int, nuts: @escaping ([Food]) -> Void){
        
        let urlString = "http://www.matapi.se/foodstuff/\(id)"
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            
                            DispatchQueue.main.async {
                              
                            var food : [Food] = []
                            var healthiness = 0.0
                            
                            let item = parsed["nutrientValues"] as! [String:Any]
                            let protein = item["protein"] as! Double
                            let fat = item["fat"] as! Double
                            let carbs = item["carbohydrates"] as! Double
                            healthiness = (protein + carbs) * fat

                            
                                food.append(Food(protein: protein, fat: fat, carbs: carbs, healthiness: healthiness))
    
                            nuts(food)
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
