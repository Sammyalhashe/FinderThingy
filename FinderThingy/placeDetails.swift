//
//  placeDetails.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-07-30.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import Foundation
import Alamofire

class placeDetails {
    
    var _placeName:String!
    var _continentName:String!
    var _longitude:Double!
    var _latitude:Double!
    
    var placeName:String! {
        get {
            return _placeName
        }
        set{
            if (newValue != nil) {
                _placeName = newValue
            }
        }
    }
    
    var continentName:String! {
        get {
            return _continentName
        }
        set{
            if (newValue != nil) {
                _continentName = newValue
            }
        }
    }

    var longitude:Double! {
        get {
            return _longitude
        }
        set{
            if (newValue != nil) {
                _longitude = newValue
            }
        }
    }
    
    var latitude:Double! {
        get {
            return _latitude
        }
        set{
            if (newValue != nil) {
                _latitude = newValue
            }
        }
    }

    
}
