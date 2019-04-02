//
//  MapAttraction.swift
//  McCollins
//
//  Created by Noh Tewolde on 4/2/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit
import GoogleMaps
//import CoreLocation

class MapAttraction: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var attraction : Attraction?
    var titleMap : String?

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoordinates()
    }
    
    func setupCoordinates(){
        let marker = GMSMarker()
        let lat = Double((attraction?.latitude)!)!
        let lng = Double((attraction?.longitude)!)!
        let location = CLLocation(latitude: lat, longitude: lng)
        marker.title = "Center"
        marker.map = mapView
        marker.position = location.coordinate
        mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
    }
}
