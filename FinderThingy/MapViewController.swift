//
//  MapViewController.swift
//  FinderThingy
//
//  Created by Sammy Alhashemi on 2017-07-15.
//  Copyright © 2017 Sammy Alhashemi. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation
import MapKit
import Alamofire


class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    /* private vars */
    private var _currentRestaurant:String!
    private var _restaurantsLatitudes:Double!
    private var _restaurantsLongitudes:Double!
    private var _searchResponse:[MKMapItem]!
    
    private var locationManager: CLLocationManager?
    private var _latitude: Double!
    private var _longitude: Double!
    private var _currentLocation:CLLocation? // stores the device's current location
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    /* Object Instanatiation */
    let marker = GMSMarker()
    var camera = GMSCameraPosition()
    var mapView = GMSMapView()
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    /* public vars */
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
    
    var searchResponse:[MKMapItem]! {
        get {
            return _searchResponse
        } set {
            if (newValue != nil) && (newValue != []) {
                _searchResponse = newValue
            }
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////


    
    /* viewdidLoad Called once */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.locationManager = CLLocationManager()
        
        
        locationAuthorizationStatus()
        
        
        mapView.delegate = self
        self.view = mapView
        
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.distanceFilter = 5.0
            self.locationManager?.startUpdatingLocation()
            self.currentLocation = locationManager?.location
            self.locationManager?.startMonitoringSignificantLocationChanges()
        } else {
            self.locationManager?.requestAlwaysAuthorization()
        }
        
//        do {
//            // Set the map style by passing the URL of the local file.
//            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                NSLog("Unable to find style.json")
//            }
//        } catch {
//            NSLog("One or more of the map styles failed to load. \(error)")
//        }
        
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /* viewDidAppear called everytime the screen shows */
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
//        do {
//            // Set the map style by passing the URL of the local file.
//            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                NSLog("Unable to find style.json")
//            }
//        } catch {
//            NSLog("One or more of the map styles failed to load. \(error)")
//        }

        
        if (CLLocationManager.locationServicesEnabled()||CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            self.currentLocation = locationManager?.location
            self.longitude = self.currentLocation?.coordinate.longitude
            self.latitude = self.currentLocation?.coordinate.latitude
            self.locationManager?.startUpdatingLocation()
            
            
        
       
            // showing the user's position on map and giving a reasonable camera zoom
            self.camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom:15)
            self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            mapView.delegate = self
            self.view = mapView
            //mapView.mapType = .normal
            mapView.isMyLocationEnabled = true
            self.mapView.settings.myLocationButton = true
        
        
            // getting my location coordinates from currentLocation
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake((self.currentLocation?.coordinate.latitude)!, (self.currentLocation?.coordinate.longitude)!)
        
            
            // creating a region object where I am
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
            
            // creating a map search request querying for the restaurant name (ie. Starbucks) in region created
            let mapSearchRequest = MKLocalSearchRequest()
            mapSearchRequest.naturalLanguageQuery = self.currentRestaurant
                mapSearchRequest.region = region
       
            
            // processing the response of the search request
            let search = MKLocalSearch(request: mapSearchRequest)
            search.start { response, error in
                guard let response = response else {
                    print("There was an error searching for: \(String(describing: mapSearchRequest.naturalLanguageQuery)) error: \(String(describing: error))")
                    return
                }
                self.searchResponse = response.mapItems
            
                var j = 1
                for item in response.mapItems {
                
                    // add markers to google maps
                    let restPosition = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                    let restMarker = GMSMarker(position: restPosition)
                    restMarker.map = self.mapView
                    restMarker.appearAnimation = .pop
                    restMarker.title = "\((self.currentRestaurant)!) \(j)"
                    restMarker.accessibilityValue = "\(j-1)"
                    print("Lat/Lon = \(restPosition.latitude)/\(restPosition.longitude)")
                    j += 1
                    
                }
            }
            } else {
                self.locationManager?.requestAlwaysAuthorization()
            }
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    /* don't really know what this does, it is default in a generated class */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /* didUpdateLocations  called when the device location updates */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // function is called whenever the location of device updates
        if (CLLocationManager.locationServicesEnabled()||CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
        
        // let location = locations[0]
        // I think the zero index is the most recent location
        let location = locations[0]
        
            
        // clearing markers previosly there
        self.mapView.clear()
        
            
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        
        // creating a region object where I am
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
            
        // creating a map search request querying for the restaurant name (ie. Starbucks) in region created
        let mapSearchRequest = MKLocalSearchRequest()
        mapSearchRequest.naturalLanguageQuery = self.currentRestaurant
        mapSearchRequest.region = region
        
            
        // processing the response of the search request
        let search = MKLocalSearch(request: mapSearchRequest)
        search.start { response, error in
            guard let response = response else {
                print("There was an error searching for: \(String(describing: mapSearchRequest.naturalLanguageQuery)) error: \(String(describing: error))")
                return
            }
            
            self.searchResponse = response.mapItems
            
            var j = 1
            for item in response.mapItems {
                
                // add markers to google maps
                let restPosition = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                let restMarker = GMSMarker(position: restPosition)
                restMarker.map = self.mapView
                restMarker.appearAnimation = .pop
                restMarker.title = "\((self.currentRestaurant)!) \(j)"
                restMarker.accessibilityValue = "\(j-1)"
                
                j += 1
            }
        }

        
        self.currentLocation = location
        self.longitude = myLocation.longitude
        self.latitude = myLocation.latitude
        
        
//        if CLLocationManager.locationServicesEnabled() {
//            //self.locationManager?.stopUpdatingLocation()
//        }
        
        // Update marker position when the device changes location
        // self.marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
        self.mapView.animate(to: camera)
        
        // print("\(longitude!), \(latitude!)")
        } else {
            self.locationManager?.requestAlwaysAuthorization()
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    /* Called when a Location error is encountered, usually no location and tries to unwrap nil */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //error handling
        print(error)
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /* Called when going back to parent */
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent != nil {
            print("back button pressed")
            // self.locationManager?.stopUpdatingLocation()
        }
       
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    /* Created this function to make location authorization easier */
    func locationAuthorizationStatus () {
        if (CLLocationManager.locationServicesEnabled()||CLLocationManager.authorizationStatus() == .authorizedAlways) {
            self.currentLocation = locationManager?.location
            
        } else {
            self.locationManager?.requestAlwaysAuthorization()
            locationAuthorizationStatus()
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /* didTap marker called when a GMSMarker is tapped! */
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        my_dest = marker.position
        my_origin = self.currentLocation?.coordinate
        
        
        let currPlace = currentPlace(currentRestaurant: self.currentRestaurant, currentLocation: self.currentLocation!, longitude: self.longitude, latitude: self.latitude, restaurantsLongitude: marker.position.longitude, restaurantsLatitude: marker.position.latitude)
        
        
        createAlert(title: "Do you want directions to \(marker.title!)", message: "Select 'Yes' if so", currPlace: currPlace)
        
        
            
        
        
        
        return false
    }
    //////////////////////////////////////////////////////////////////////////////////////
    
    

    /* Function I made to create a popup asking if I want the directions */
    func createAlert(title:String, message:String,currPlace:currentPlace) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let YesactionToAdd = UIAlertAction(title: "Yes", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
            
            currPlace.downloadDirectionsData {
                //code
                //let overPolylines:[String] = currPlace.overViewPolylines
                let overPolylines = currPlace.overViewPolylines as? String
                
                var polyLines:[GMSPolyline] = []
                
                
                print(currPlace.processComplete)
                print(overPolylines)
                
                let path:GMSMutablePath = GMSMutablePath(fromEncodedPath: (overPolylines)!)!
                polyLines.append(GMSPolyline(path: path))
                polyLines[0].map = self.mapView
            }

        })
        
        
        let NoactionToAdd = UIAlertAction(title: "No", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
            return
        })
        
        
        alert.addAction(YesactionToAdd)
        alert.addAction(NoactionToAdd)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
     //////////////////////////////////////////////////////////////////////////////////////
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
