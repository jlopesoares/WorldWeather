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
    var _selectedCities: [Int]!
    var _editMode: Bool!
    
    @IBOutlet weak var citiesTableview: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintTableView: NSLayoutConstraint!
    
    
    var selectedCities: [Int]{
        if _selectedCities == nil {
            _selectedCities = [Int]()
        }
        return _selectedCities
    }
    
    var shouldBeEditable: Bool {
        if _editMode == nil {
            _editMode = false
        }
        return _editMode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchTextField.delegate = self
        citiesTableview.dataSource = self
        citiesTableview.delegate = self
        collectionView.dataSource = self
        citiesTableview.separatorColor = UIColor.lightGray
        
        getCitiesList()
        setupNavigationBarButtons()
        setupObservers()
    }
    
    func getSelectedCell(longGestureHandler: UILongPressGestureRecognizer) {
        if longGestureHandler.state == .recognized {
            let location = longGestureHandler.location(in: collectionView)
            
            if let indexpath = collectionView.indexPathForItem(at: location) {
                if let cell = collectionView.cellForItem(at: indexpath) as? CityCell {

                    if let index = selectedCities.index(of: Int(cell.cityNameLabel.text!)!) {
                        _selectedCities.remove(at: index)
                        UserDefaults.standard.set(selectedCities, forKey: "selectedCities")
                        collectionView.deleteItems(at: [indexpath])

                    }
                }
            }
        }
    }
    
    func setupNavigationBarButtons() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
        navigationItem.rightBarButtonItem = editButton
        
    }
    
    func editButtonPressed () {
        _editMode = !shouldBeEditable
        collectionView.reloadData()
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDissapear), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
            if keyboardSize.height > 0 {
                heightTableViewConstraint.constant = heightTableViewConstraint.constant - keyboardSize.height - searchTextField.bounds.height
            }
        }
    }
//    
//    func keyboardWillDissapear(notification: NSNotification) {
//        //TODO: Something when keyboard will close
//    }
    
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
    
    
    func getCity(cityID: Int) -> City?{
        
        for city in cities {
            if cityID == city.identifier {
                return city
            }
        }
        return nil
    }
    
}

//MARK: UITextFieldDelegate
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

//MARK: UITableViewDatasource
extension CitiesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        let city = cities[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.text = "\(city.name), \(city.country)"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
}

//MARK: UICollectionViewDatasource
extension CitiesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as? CityCell {
            
            if let city =  getCity(cityID: selectedCities[indexPath.row]) {
                cell.setupCellWith(city: city, editAvailable: shouldBeEditable)
                cell.delegate = self
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
}


//Mark: UICollectionViewDelegate

extension CitiesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = cities[indexPath.row]
        
        _selectedCities.append(city.identifier)
        UserDefaults.standard.set(selectedCities, forKey: "selectedCities")
        collectionView.reloadData()
        endSearch()
    }
    
}

extension CitiesVC: CityCellDelegate {
    
    func deleteCity(cell: CityCell, city: City) {
        
        if let indexpath = collectionView.indexPath(for: cell) {
            if let index = selectedCities.index(of: Int(city.identifier)) {
                _selectedCities.remove(at: index)
                UserDefaults.standard.set(selectedCities, forKey: "selectedCities")
                collectionView.deleteItems(at: [indexpath])
                
            }
        }
    }
}
