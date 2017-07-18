//
//  Places.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-07-15.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import Foundation

class Places {
    
    // Class holds all types of places considered
    
    let coffeePlaces = ["Starbucks","Tim Hortons","Second Cup","Timothy's World Coffee"]
    let pizzaPlaces = ["PizzaPizza","Pizza Nova","Domino's Pizza","Gino's Pizza"]
    
    private var _places: [String]!
    
    var places: [String]! {
        get {
            return _places
        }
        set {
            if (newValue != nil) {
                _places = newValue
            }
        }
        
    }
    
    init(type: String) {
        if type == "Pizza" {
            self._places = pizzaPlaces
        }
        else {
            self._places = coffeePlaces
        }
    }
}
