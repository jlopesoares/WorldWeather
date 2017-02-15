//
//  CitiesVC.swift
//  WorldWeather
//
//  Created by João Soares on 13/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit
import Foundation

class CitiesVC: UIViewController {
    
    
    var cities = [City]()

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var citiesTableview: UITableView!
    
    @IBOutlet weak var widthConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        searchTextField.delegate = self
        
        getCitiesList()
        
        citiesTableview.dataSource = self
        
    }
    
    func getCitiesList() {
        
        do {
            if let file = Bundle.main.url(forResource: "cities", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let object = json as? [Any] {
                    
                    for index in 0...object.count-1 {

                        if let city = object[index] as? Dictionary<String, AnyObject> {
                            let currentCity = City(city: city)
                            cities.append(currentCity)
                        }
                        
                    }

                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    
    }
    
    func startSearch() {
        heightTableViewConstraint.constant = view.bounds.height - searchTextField.bounds.height
        
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        }) { finished in
            self.widthConstraintTableView.constant = self.view.bounds.width
            UIView.animate(withDuration: 0.6, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                if finished {
                    self.searchTextField.becomeFirstResponder()
                }
            })
        }
    }
    
    func endSearch() {
        
        self.widthConstraintTableView.constant = 250
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                self.heightTableViewConstraint.constant = 0
                UIView.animate(withDuration: 0.6, animations: {
                    self.view.layoutIfNeeded()
                }) { finished in
                    self.searchTextField.resignFirstResponder()
                }
                
            }
        })

    }

    
    func updateTableView(searchText: String) {
        //filter cities array
    }
    
}



extension CitiesVC: UITextFieldDelegate {
    
    //setup list of cities/locations (squares with background)
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        startSearch()
        
        if(citiesTableview.bounds.width == view.bounds.width) {
            return true
        }
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            //update tableView
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endSearch()
        
        if(citiesTableview.bounds.height == 0) {
            return true
        }
        return false
    }
}

extension CitiesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        let city = cities[indexPath.row]
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        cell.textLabel?.text = city._name
        
        return cell
    }
    
}
