//
//  StartViewController.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-09-09.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // button outlets
    @IBOutlet weak var coffeeOutlet: UIButton!
    
    @IBOutlet weak var FastFoodOutlet: UIButton!
    @IBOutlet weak var tennisOutlet: UIButton!
    @IBOutlet weak var movieOutlet: UIButton!
    @IBOutlet weak var soccerOutlet: UIButton!
    
    var buttonLabel: String?
    
    @IBAction func button_pressed(sender: UIButton) {
        if (sender.titleLabel?.text == "Coffee")||(sender.titleLabel?.text == "Fast Food")||(sender.titleLabel?.text == "Movies") {
            
            self.buttonLabel = sender.titleLabel?.text
            performSegue(withIdentifier: "SeguetoTableView", sender: sender.self)
            
            
        }
        
    }

   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
         // adding targets to buttons
        coffeeOutlet.addTarget(self, action: #selector(button_pressed(sender:)), for: .touchUpInside)
        FastFoodOutlet.addTarget(self, action: #selector(button_pressed(sender:)), for: .touchUpInside)
        movieOutlet.addTarget(self, action: #selector(button_pressed(sender:)), for: .touchUpInside)
        soccerOutlet.addTarget(self, action: #selector(button_pressed(sender:)), for: .touchUpInside)
        tennisOutlet.addTarget(self, action: #selector(button_pressed(sender:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        
        if (self.buttonLabel! == "Coffee")||(self.buttonLabel! == "Fast Food")||(self.buttonLabel! == "Movies") {
            let tableViewScene = segue.destination as? ViewController
            // Pass the selected object to the new view controller.
            tableViewScene?.typeOfThing = self.buttonLabel
        } else {
            let mapsegScene = segue.destination as? MapViewController
            mapsegScene?.currentRestaurant = "Starbucks" //trial
        }
        
    }
    

}
