//
//  LocationViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: BaseViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
        self.centerToLocation()
        self.showAnnotion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setText() {
        self.navigationItem.title = localizedString("__t_location_title")
    }
    
    func initialLocation() -> CLLocation {
        guard let user = self.user, let address = user.address, let geo = address.geo else {
            return CLLocation(latitude: 0, longitude: 0)
        }
        let latitude: Double = Double(geo.lat)!
        let longitude: Double = Double(geo.long)!
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func centerToLocation() {
        let regionRadius: CLLocationDistance = 10000
        
        let coordinateRegion = MKCoordinateRegion(
            center: self.initialLocation().coordinate,
              latitudinalMeters: regionRadius,
              longitudinalMeters: regionRadius)
        
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showAnnotion() {
        guard let user = self.user, let company = user.company else { return }
        let location = MKPointAnnotation()
        location.title = company.name
        location.subtitle = company.bs
        location.coordinate = self.initialLocation().coordinate
        self.mapView.addAnnotation(location)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }

            return annotationView
    }
}
