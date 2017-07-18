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
    
    let pizza = Places(type: "Pizza")
    let coffee = Places(type: "Coffee")
    var selectedIndexPath:IndexPath?
    
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
        if section == 0 {
            return coffee.places.count
        }
            
        else {
            return pizza.places.count
        }
    }
    
    // How many sections are there? Is it one list or more than one?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Coffee Shops"
        } else {
            return "Pizza Places"
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
        
        if indexPath.section == 0 {
            // Some optional chaining here
            cell.textLabel?.text = coffee.places[indexPath.row]
            
        }
            
        else {
            // Some optional chaining here
            cell.textLabel?.text = pizza.places[indexPath.row]
            
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
                if indexPath.section == 0 {
                    let selectedRestaurant = coffee.places[indexPath.row]
                    mapScene?.currentRestaurant = selectedRestaurant
                }else{
                    let selectedRestaurant = pizza.places[indexPath.row]
                    mapScene?.currentRestaurant = selectedRestaurant
                }
            }
        }
    }


}

