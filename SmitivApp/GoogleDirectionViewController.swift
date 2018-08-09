//
//  GoogleDirectionViewController.swift
//  SmitivApp
//
//  Created by Suresh on 08/08/18.
//  Copyright © 2018 SmitivApp. All rights reserved.
//

import UIKit
import CoreLocation
import PXGoogleDirections
import GoogleMaps

protocol GoogleViewControllerDelegate {
    func didAddWaypoint(_ waypoint: PXLocation)
}

class GoogleDirectionViewController: UIViewController, PXGoogleDirectionsDelegate  {

    var isViewDidLoad: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isViewDidLoad {
            isViewDidLoad = false
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate var directionsAPI: PXGoogleDirections {
        return (UIApplication.shared.delegate as! AppDelegate).directionsAPI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false
        
        isViewDidLoad = true
        
        directionsAPI.delegate = self
        directionsAPI.from = PXLocation.namedLocation("Hyderabad")
        directionsAPI.to = PXLocation.namedLocation("Chennai")
        
        directionsAPI.mode = PXGoogleDirectionsMode(rawValue: 0)      //by travel mode car
        
        /*
        if advancedSwitch.isOn {
            directionsAPI.transitRoutingPreference = transitRoutingPreferenceFromField()
            directionsAPI.trafficModel = trafficModelFromField()
            directionsAPI.units = unitFromField()
            directionsAPI.alternatives = alternativeSwitch.isOn
            directionsAPI.transitModes = Set()
            if busSwitch.isOn {
                directionsAPI.transitModes.insert(.bus)
            }
            if subwaySwitch.isOn {
                directionsAPI.transitModes.insert(.subway)
            }
            if trainSwitch.isOn {
                directionsAPI.transitModes.insert(.train)
            }
            if tramSwitch.isOn {
                directionsAPI.transitModes.insert(.tram)
            }
            if railSwitch.isOn {
                directionsAPI.transitModes.insert(.rail)
            }
            directionsAPI.featuresToAvoid = Set()
            if avoidTollsSwitch.isOn {
                directionsAPI.featuresToAvoid.insert(.tolls)
            }
            if avoidHighwaysSwitch.isOn {
                directionsAPI.featuresToAvoid.insert(.highways)
            }
            if avoidFerriesSwitch.isOn {
                directionsAPI.featuresToAvoid.insert(.ferries)
            }
            switch startArriveField.selectedSegmentIndex {
            case 0:
                directionsAPI.departureTime = .now
                directionsAPI.arrivalTime = nil
            case 1:
                if let saDate = startArriveDate {
                    directionsAPI.departureTime = PXTime.timeFromDate(saDate)
                    directionsAPI.arrivalTime = nil
                } else {
                    return
                }
            case 2:
                if let saDate = startArriveDate {
                    directionsAPI.departureTime = nil
                    directionsAPI.arrivalTime = PXTime.timeFromDate(saDate)
                } else {
                    return
                }
            default:
                break
            }
            directionsAPI.waypoints = waypoints
            directionsAPI.optimizeWaypoints = optimizeWaypointsSwitch.isOn
            directionsAPI.language = languageFromField()
        } else {
 
        */
            directionsAPI.transitRoutingPreference = nil
            directionsAPI.trafficModel = nil
            directionsAPI.units = nil
            directionsAPI.alternatives = nil
            directionsAPI.transitModes = Set()
            directionsAPI.featuresToAvoid = Set()
            directionsAPI.departureTime = nil
            directionsAPI.arrivalTime = nil
            directionsAPI.waypoints = [PXLocation]()
            directionsAPI.optimizeWaypoints = nil
            directionsAPI.language = nil
        //}
        // directionsAPI.region = "fr" // Feature not demonstrated in this sample app
        directionsAPI.calculateDirections { (response) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                switch response {
                case let .error(_, error):
                    let alert = UIAlertController(title: "SmitivApp", message: "Error: \(error.localizedDescription)", preferredStyle:UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GoogleDirectionViewController: GoogleViewControllerDelegate {
        func didAddWaypoint(_ waypoint: PXLocation) {
            //waypoints.append(waypoint)
            //updateWaypointsField()
        }
}

