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
    
    let coffeePlaces = ["Starbucks","Tim Hortons","Second Cup","Timothy's World Coffee","Peets Coffee & Tea","The Coffee Bean & Tea Leaf"]
    let fastFoodPlaces = ["zpizza","Pizza Nova","Domino's Pizza","Gino's Pizza","McDonalds","In-N-Out","FiveGuys"]
    let moviePlaces = ["Cineplex","AMC"]
    
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
        if type == "Fast Food" {
            self._places = fastFoodPlaces
        }
        if type == "Coffee" {
            self._places = coffeePlaces
        }
        if type == "Movie" {
            self._places = moviePlaces
        }
    }
}
