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

class MapViewController: UIViewController, CLLocationManagerDelegate {

    private var _currentRestaurant:String!
    
    private var googleMapView: GMSMapView!
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


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.startUpdatingLocation() /* need this even though it's in viewdidappear. Maybe viewdidload only called once? */
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.distanceFilter = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // This part is for the device location //
        self.locationManager?.startUpdatingLocation()
    
        // 2: assuming after coordinates updated in didUpdateLocations
        let coordinates = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let marker = GMSMarker(position: coordinates)
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        //self.view = mapView
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        marker.position = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        marker.title = "I am here"
        marker.map = mapView
        
        //////////////////////////////////////////
        // This part is for restaurant location //
        
        
        //////////////////////////////////////////

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // function keeps an update on the devices current location
        // let locationsCount = locations.count
        // self.currentLocation = locations[locationsCount-1]
        self.currentLocation = locations.last
        
        
        // 1: update the coordinates when location is updated
        self.latitude = self.currentLocation?.coordinate.latitude
        self.longitude = self.currentLocation?.coordinate.longitude
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //error handling
        print(error)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent != nil {
            print("back button pressed")
            self.locationManager?.stopUpdatingLocation()
        }
       
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
