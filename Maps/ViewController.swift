//
//  ViewController.swift
//  Maps
//
//  Created by Birdi on 28-08-21.
//

import UIKit
import MapKit
import SwiftUI

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    
    
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.startUpdatingLocation()
            renderMap(location: location)
        }
    }
    
    func renderMap(location: CLLocation){
        let coordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapa.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        pin.title = "Aquí estoy"
        pin.subtitle = "Lat: \(location.coordinate.latitude) Long:\(location.coordinate.longitude)"
        mapa.addAnnotation(pin)
        
        
    }
    
    
    @IBSegueAction func segueSwiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: HomeSwiftUIView())
    }
    
}

