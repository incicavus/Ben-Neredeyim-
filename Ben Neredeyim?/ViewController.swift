//
//  ViewController.swift
//  Ben Neredeyim?
//
//  Created by İnci Çavuş on 6.03.2019.
//  Copyright © 2019 İnci Çavuş. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var choosenLat = Double()
    var choosenLng = Double()
    
    var selectedLat : Double = 0
    var selectedLng : Double = 0
    
    var requestCLLocation = CLLocation()

    let geocoder = CLGeocoder()
    var locality = ""
    var administrativeArea = ""
    var country = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let myLocation = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        let addPin = MKPointAnnotation()
        addPin.coordinate = myLocation
        addPin.title = "Ben Buradayım!"
     
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        self.mapView.addAnnotation(addPin)
        
    }

   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        
        let reuseID = "myAnnotation"
        
        var pinView =  mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = UIColor.black
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }
            
        else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }

}

