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
            print(response)
            
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
