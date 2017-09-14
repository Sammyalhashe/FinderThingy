//
//  ViewController.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-07-15.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let fastfood = Places(type: "Fast Food")
    let coffee = Places(type: "Coffee")
    let movie = Places(type: "Movie")
    var selectedIndexPath:IndexPath?
    
    private var _typeOfThing:String!
    
    var typeOfThing:String! {
        get {
            return _typeOfThing
        } set {
            if (newValue != nil) && (newValue != "") {
                _typeOfThing = newValue
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // How many rows in each section?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return coffee.places.count
//        }
//            
//        else {
//            return pizza.places.count
//        }
        if self.typeOfThing! == "Fast Food" {
            return fastfood.places.count
        }
        if self.typeOfThing! == "Coffee" {
            return coffee.places.count
        }
        if self.typeOfThing! == "Movies" {
            return movie.places.count
        }
        else {
            return 0
        }
    }
    
    // How many sections are there? Is it one list or more than one?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Coffee Shops"
//        } else {
//            return "Pizza Places"
//        }
        if self.typeOfThing! == "Fast Food" {
            return "Fast Food Places"
        }
        if self.typeOfThing! == "Coffee" {
            return "Coffee Places"
        }
        if self.typeOfThing! == "Movies" {
            return "Movie Theatres"
        }
        else {
            return nil
        }
    }

    
    // How we load the data in each cell. Called a number of times depending on whats returned by numberOfRowsInSection above
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Below is the recommended way of creating cells; makes them "reusable". TableView is a UITableView Object already so I can do this. Note: Need one prototype cell in the storyboard initiated...
        
        let cellIdentifier = "cell"
        // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StoreCellClassTableViewCell  else {
            fatalError("The dequeued cell is not an instance of StoreCellClassTableViewCell.")
        }
        
        
        // The as? StoreCellClassTableViewCell expression attempts to downcast the returned object from the UITableViewCell class to your StoreCellClassTableViewCell class. This returns an optional. The guard statement lets you safely unwrap an optional by giving you and else clause in case something goes wrong.
        
//        if indexPath.section == 0 {
//            // Some optional chaining here
//            cell.textLabel?.text = coffee.places[indexPath.row]
//            
//        }
//            
//        else {
//            // Some optional chaining here
//            cell.textLabel?.text = pizza.places[indexPath.row]
//            
//        }
        
        if self.typeOfThing! == "Fast Food" {
            cell.textLabel?.text = fastfood.places[indexPath.row]
        }
        if self.typeOfThing! == "Coffee" {
            cell.textLabel?.text = coffee.places[indexPath.row]
        }
        if self.typeOfThing! == "Movies" {
            cell.textLabel?.text = movie.places[indexPath.row]
        }

        
        return cell
    }
    
    /* DON'T NEED THIS METHOD AS I HAD MANUALLY CREATED A TRIGGERED SEGUE IN MAIN.STORYBOARD
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let selectedRestaurant:String?
        selectedIndexPath = indexPath
        /*
        if indexPath.section == 0 {
            selectedRestaurant = coffee.places[indexPath.row]
        } else {
            selectedRestaurant = pizza.places[indexPath.row]
            
        }*/
        
        //performSegue(withIdentifier: "mapSegue", sender: selectedRestaurant)
    }
 */
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            // Get the new view controller using segue.destinationViewController.
            let mapScene = segue.destination as? MapViewController // Casting an "Any Object" object into a MapViewController Object
            // Pass the selected object to the new view controller.
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
//                if indexPath.section == 0 {
//                    let selectedRestaurant = coffee.places[indexPath.row]
//                    mapScene?.currentRestaurant = selectedRestaurant
//                }else{
//                    let selectedRestaurant = fastfood.places[indexPath.row]
//                    mapScene?.currentRestaurant = selectedRestaurant
//                }
                if self.typeOfThing! == "Fast Food" {
                    let selectedRestaurant = fastfood.places[indexPath.row]
                    mapScene?.currentRestaurant = selectedRestaurant
                }
                if self.typeOfThing! == "Coffee" {
                    let selectedRestaurant = coffee.places[indexPath.row]
                    mapScene?.currentRestaurant = selectedRestaurant
                }
                if self.typeOfThing! == "Movies" {
                    let selectedRestaurant = movie.places[indexPath.row]
                    mapScene?.currentRestaurant = selectedRestaurant
                }
                
            }
            
        }
    }


}

