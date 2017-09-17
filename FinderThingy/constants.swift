//
//  constants.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-09-16.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import Foundation
import CoreLocation


let BASE_URL = "https://maps.googleapis.com/maps/api/directions/json?"

var my_origin:CLLocationCoordinate2D?
var origin_lat = my_origin!.latitude
var origin_lon = my_origin!.longitude

var my_dest:CLLocationCoordinate2D?
var dest_lat = my_dest!.latitude
var dest_lon = my_dest!.longitude

let origin = "origin="
let destination = "&destination="
let key = "&key=AIzaSyAkxOZo5xRU6kodQFeKOMK7WXE2DSEtsFo"

let direction_request_URL = "\(BASE_URL)\(origin)\(origin_lat),\(origin_lon)\(destination)\(dest_lat),\(dest_lon)\(key)" // provides default values

typealias downloadComplete = () -> () //will tell when download complete
