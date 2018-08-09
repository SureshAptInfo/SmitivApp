//
//  ResultsViewController.swift
//  SmitivApp
//  Created by Suresh on 08/08/18.
//  Copyright © 2018 SmitivApp. All rights reserved.
//

import UIKit
import PXGoogleDirections
import GoogleMaps
import CoreLocation

class ResultsViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - IBOutlets
	//@IBOutlet weak var prevButton: UIButton!
	//@IBOutlet weak var routesLabel: UILabel!
	//@IBOutlet weak var nextButton: UIButton!
    
	@IBOutlet weak var mapView: GMSMapView!
	@IBOutlet weak var directions: UITableView!
	var request: PXGoogleDirections!
	var results: [PXGoogleDirectionsRoute]!
	var routeIndex: Int = 0
	
    var userLocation: CLLocation!
    var curLongitude: Double!
    var curLatitude: Double!
    
    lazy var locationManager: CLLocationManager =
        {
            var _locationManager = CLLocationManager()
            _locationManager.delegate = self
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest
            _locationManager.activityType = .automotiveNavigation
            _locationManager.distanceFilter = kCLDistanceFilterNone  //10.0  // Movement threshold for new events
            //_locationManager.allowsBackgroundLocationUpdates = true // allow in background
            
            return _locationManager
    }()
    
    
    fileprivate var directionsAPI: PXGoogleDirections {
        return (UIApplication.shared.delegate as! AppDelegate).directionsAPI
    }
    
    //MARK: - ViewController Delegate
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateRoute()
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self

        //let locationManager = CLLocationManager()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .notDetermined, .restricted, .denied:
                print("No access")
                    //self.ShowAlertForLocationAccess()
            case .authorizedAlways:
                print("Access")
            case .authorizedWhenInUse:
                print("Access")
            }
        
        }
        else {
            print("Location services are not enabled")
            self.ShowAlertForLocationAccess()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
	}
	
    
    //MARK: - IBActions
    @IBAction func RefreshButtonClicked() {
        
        self.RefreshCurrenLocation()
    }
    
    @IBAction func previousButtonTouched(_ sender: UIButton) {
        routeIndex -= 1
        updateRoute()
    }
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        routeIndex += 1
        updateRoute()
    }
    
    @IBAction func closeButtonTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openInGoogleMapsButtonTouched(_ sender: UIButton) {
        if !request.openInGoogleMaps(center: nil, mapMode: .streetView, view: Set(arrayLiteral: PXGoogleMapsView.satellite, PXGoogleMapsView.traffic, PXGoogleMapsView.transit), zoom: 15, callbackURL: URL(string: "pxsample://"), callbackName: "PXSample") {
            let alert = UIAlertController(title: "SmitivApp", message: "Could not launch the Google Maps app. Maybe this app is not installed on this device?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK: - LocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if userLocation == nil
        {
            userLocation = locations.last
            print("**********************")
            print("Long \(userLocation?.coordinate.longitude)")
            print("Lati \(userLocation?.coordinate.latitude)")
            print("Alt \(userLocation?.altitude)")
            print("Sped \(userLocation?.speed)")
            print("Accu \(userLocation?.horizontalAccuracy)")
            
            print("**********************")
            
            
            curLatitude = userLocation?.coordinate.latitude
            curLongitude = userLocation?.coordinate.longitude
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(userLocation!, completionHandler: { (placemarks, e) -> Void in
                if e != nil {
                    print("Error:  \(String(describing: e))")
                    
                    self.showAlert(title: "", message: String(describing: e))
                    
                } else {
                    let placemark = (placemarks?.last)! as CLPlacemark
                    
                    let userInfo = [
                        "city":     placemark.locality,
                        "state":    placemark.administrativeArea,
                        "country":  placemark.country,
                        "countryCode":  placemark.isoCountryCode
                    ]
                    
                    print("Location:  \(userInfo)")
                    //print(placemark.isoCountryCode! as NSString)
                
                    
                self.locationManager.stopUpdatingLocation()
                    self.locationManager.delegate = nil
                    
                
                    
                    
                    
                }
            })
        }
    }
    
    func RefreshCurrenLocation() {
        directionsAPI.from = PXLocation.coordinateLocation(CLLocationCoordinate2DMake((self.userLocation?.coordinate.latitude)!, (self.userLocation?.coordinate.longitude)!))
        //directionsAPI.to = PXLocation.namedLocation("Chennai")
        
        directionsAPI.to = PXLocation.coordinateLocation(CLLocationCoordinate2DMake(13.0827, 80.2707))
        
        //13.0827
        
        //80.2707
        
        directionsAPI.calculateDirections { (response) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                switch response {
                case let .error(_, error):
                    let alert = UIAlertController(title: "SmitivApp", message: "Error: \(error.localizedDescription)", preferredStyle:UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case let .success(request, routes):
                    if let rvc = self.storyboard?.instantiateViewController(withIdentifier: "Results") as? ResultsViewController {
                        rvc.request = request
                        rvc.results = routes
                        self.present(rvc, animated: true, completion: nil)
                    }
                }
            })
            
        }
    }
    
    //MARK: - AlertViewController
    func showAlert(title: String, message: String)
    {
        //simple alert dialog
        let alert=UIAlertController(title: "SmitivApp", message: message, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        //show it
        
        DispatchQueue.main.async
            {
                //show(alert, sender: self)
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    func ShowAlertForLocationAccess()
    {
        let alert = UIAlertController(title: "SmitivApp", message: "GPS access is restricted. Please enable GPS in the Settings app under Privacy, Location Services.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            
            UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
        }))
        
        DispatchQueue.main.async {
            //show(alert, sender: self)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
	
	func updateRoute() {
		//prevButton.isEnabled = (routeIndex > 0)
		//nextButton.isEnabled = (routeIndex < (results).count - 1)
		//routesLabel.text = "\(routeIndex + 1) of \((results).count)"
		mapView.clear()
		for i in 0 ..< results.count {
			if i != routeIndex {
				results[i].drawOnMap(mapView, approximate: false, strokeColor: UIColor.lightGray, strokeWidth: 3.0)
			}
		}
		mapView.animate(with: GMSCameraUpdate.fit(results[routeIndex].bounds!, withPadding: 40.0))
		results[routeIndex].drawOnMap(mapView, approximate: false, strokeColor: UIColor.purple, strokeWidth: 4.0)
		results[routeIndex].drawOriginMarkerOnMap(mapView, title: "Origin", color: UIColor.green, opacity: 1.0, flat: true)
		results[routeIndex].drawDestinationMarkerOnMap(mapView, title: "Destination", color: UIColor.red, opacity: 1.0, flat: true)
		directions.reloadData()
	}
}

//MARK: - Extension
extension ResultsViewController: GMSMapViewDelegate {
}

//MARK: - UITableView Delegates
extension ResultsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return (results[routeIndex].legs).count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (results[routeIndex].legs[section].steps).count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let leg = results[routeIndex].legs[section]
		if let dist = leg.distance?.description, let dur = leg.duration?.description {
			return "Step \(section + 1) (\(dist), \(dur))"
		} else {
			return "Step \(section + 1)"
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "RouteStep")
		if (cell == nil) {
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: "RouteStep")
		}
		let step = results[routeIndex].legs[indexPath.section].steps[indexPath.row]
		if let instr = step.rawInstructions {
			cell!.textLabel!.text = instr
		}
		if let dist = step.distance?.description, let dur = step.duration?.description {
			cell!.detailTextLabel?.text = "\(dist), \(dur)"
		}
		return cell!
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let step = results[routeIndex].legs[indexPath.section].steps[indexPath.row]
		mapView.animate(with: GMSCameraUpdate.fit(step.bounds!, withPadding: 40.0))
	}
	
	func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		let step = results[routeIndex].legs[indexPath.section].steps[indexPath.row]
		var msg: String
		if let m = step.maneuver {
			msg = "\(step.rawInstructions!)\nGPS instruction: \(m)\nFrom: (\(step.startLocation!.latitude); \(step.startLocation!.longitude))\nTo: (\(step.endLocation!.latitude); \(step.endLocation!.longitude))"
		} else {
			msg = "\(step.rawInstructions!)\nFrom: (\(step.startLocation!.latitude); \(step.startLocation!.longitude))\nTo: (\(step.endLocation!.latitude); \(step.endLocation!.longitude))"
		}
        
        
		let alert = UIAlertController(title: "SmitivApp", message: msg, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		//self.present(alert, animated: true, completion: nil)
 
	}
}

extension ResultsViewController: UITableViewDelegate {
}
