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


class MapViewController: UIViewController, CLLocationManagerDelegate {

    private var _currentRestaurant:String!
    private var _restaurantsLatitudes:Double!
    private var _restaurantsLongitudes:Double!
    
    
    private var googleMapView: GMSMapView!
    private var locationManager: CLLocationManager?
    private var _latitude: Double!
    private var _longitude: Double!
    private var _currentLocation:CLLocation? // stores the device's current location
    private var _myReg:CLCircularRegion?
    
    
    let marker = GMSMarker()
    lazy var geocoder = CLGeocoder() // lazy var doesn't have its value calculated until it is first used
    var camera = GMSCameraPosition()
    var mapView = GMSMapView()
    
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
    
    var myReg:CLCircularRegion? {
        get {
            return _myReg
        } set {
            if (newValue != nil) {
                _myReg = newValue
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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager = CLLocationManager()
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.requestWhenInUseAuthorization()
       
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.distanceFilter = 5.0
            self.locationManager?.startUpdatingLocation()
        }
        // print(currentRestaurant) // checked: restaurant name gets through segue
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.startUpdatingLocation()
        
        
        // showing the user's position on map and giving a reasonable camera zoom
        self.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom:15)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        mapView.mapType = .normal
        mapView.isMyLocationEnabled = true
        
        // adding a marker designating my position
        // self.marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // self.marker.title = "MY Location"
        // self.marker.map = mapView
        
        
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
            
            var j = 1
            for item in response.mapItems {
                
                // add markers to google maps
                let restPosition = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                let restMarker = GMSMarker(position: restPosition)
                restMarker.map = self.mapView
                restMarker.appearAnimation = .pop
                restMarker.title = "\((self.currentRestaurant)!) \(j)"
                print("Lat/Lon = \(restPosition.latitude)/\(restPosition.longitude)")
                j += 1

            }
        }

        } else {
            self.locationManager?.requestAlwaysAuthorization()
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // function is called whenever the location of device updates
        if CLLocationManager.locationServicesEnabled() {
            
        
        // let location = locations[0]
        // I think the zero index is the most recent location
        let location = locations[0]
        
        // clearing markers previosly there
        self.mapView.clear()
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        // let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        
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
            
            var j = 1
            for item in response.mapItems {
                
                // add markers to google maps
                let restPosition = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                let restMarker = GMSMarker(position: restPosition)
                restMarker.map = self.mapView
                restMarker.appearAnimation = .pop
                restMarker.title = "\((self.currentRestaurant)!) \(j)"
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
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //error handling
        print(error)
    }
    
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent != nil {
            print("back button pressed")
            // self.locationManager?.stopUpdatingLocation()
        }
       
    }
    
//    // private methods
//    
//    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
//        // Update View
//        
//        if let error = error {
//            print("Unable to Forward Geocode Address (\(error))")
//            
//            
//        } else {
//            var location: CLLocation?
//            
//            if let placemarks = placemarks, placemarks.count > 0 {
//                location = placemarks.first?.location
//            }
//            
//            if let location = location {
//                let coordinate = location.coordinate
//                restaurantsLatitude = coordinate.latitude
//                restaurantsLongitude = coordinate.longitude
//                
//                print("\(restaurantsLongitude!) \(restaurantsLatitude!)")
//                
//            } else {
//                print("No Matching Location Found")
//            }
//        }
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
