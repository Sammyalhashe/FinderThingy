//
//  currentPlace.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-09-16.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation
import MapKit
import Alamofire

class currentPlace {
    
    private var _currentRestaurant:String!
    private var _restaurantsLatitudes:Double!
    private var _restaurantsLongitudes:Double!
    
    private var locationManager: CLLocationManager?
    private var _latitude: Double!
    private var _longitude: Double!
    private var _currentLocation:CLLocation? // stores the device's current location
    

    
    var currentRestaurant:String! {
        get {
            return _currentRestaurant
        } set {
            if (newValue != nil) && (newValue != "") {
                _currentRestaurant = newValue
            }
        }
    }
    
    var currentLocation:CLLocation? {
        get {
            return _currentLocation
        } set {
            if (newValue != nil) {
                _currentLocation = newValue
            }
        }
    }
    
    
    var longitude:Double! {
        get {
            return _longitude
        } set {
            if (newValue != nil) {
                _longitude = newValue
            }
        }
    }
    
    var latitude:Double! {
        get {
            return _latitude
        } set {
            if (newValue != nil){
                _latitude = newValue
            }
        }
    }
    
    var restaurantsLongitude:Double! {
        get {
            return _restaurantsLongitudes
        } set {
            if (newValue != nil) {
                _restaurantsLongitudes = newValue
            }
        }
    }
    
    var restaurantsLatitude:Double! {
        get {
            return _restaurantsLatitudes
        } set {
            if (newValue != nil){
                _restaurantsLatitudes = newValue
            }
            
        }
    }

    
    func downloadDirectionsData (completed: downloadComplete) {
        // Alamofire Download
        let directionsURL = URL(string: direction_request_URL)!
        Alamofire.request(directionsURL, method: .get).responseJSON { response in
            let result = response.result
            print(direction_request_URL)
            //print(result)
            if let directionsDict = result.value as? Dictionary<String,AnyObject> {
                if let routes = directionsDict["routes"] {
                    if let firstRoute = routes[0] as? Dictionary<String,AnyObject>{
                        if let legs = firstRoute["legs"] as? [Dictionary<String,AnyObject>?]{
                            for i in 0...(legs.count-1) {
                                if let leg = legs[i] {
                                    if let distance = leg["distance"] as? Dictionary<String,AnyObject>, let steps = leg["steps"] as? [Dictionary<String,AnyObject>?] {
                                        print("distance to destination: \(distance["text"]!)")
                                        for k in 0...(steps.count-1) {
                                            if let step = steps[k] {
                                                if let stepDist = step["distance"] as? Dictionary<String,AnyObject>, let stepDuration = step["duration"] as? Dictionary<String,AnyObject>, let html_Instr = step["html_instructions"] {
                                                    print("Step Distance: \(stepDist["text"]!)\n")
                                                    print("Step Duration: \(stepDuration["text"]!)\n")
                                                    print("HTML to process: \(html_Instr)\n")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        completed() // type-alias defined in constants file
    }
    
    init(currentRestaurant:String,currentLocation:CLLocation,longitude:Double, latitude:Double,restaurantsLongitude:Double,restaurantsLatitude:Double) {
        self.currentRestaurant = currentRestaurant
        self.currentLocation = currentLocation
        self.longitude = longitude
        self.latitude = latitude
        self.restaurantsLongitude = restaurantsLongitude
        self.restaurantsLatitude = restaurantsLatitude
    }

}
