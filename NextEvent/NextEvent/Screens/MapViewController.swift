//
//  MapViewController.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-18.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var detailEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.MapView.setCenterCoordinate(myLocation, animated: true)
        
        let eventLocation = CLLocationCoordinate2D(latitude: detailEvent.getLatitude(), longitude: detailEvent.getLongitude())
        
        // create a location
        let location = MKPointAnnotation()
        // add title and coordinate
        location.title = detailEvent.title
        location.coordinate = eventLocation
        // show pin
        mapView.addAnnotation(location)
        // show the pin in the center on the mapview
        mapView.setCenter(eventLocation, animated: true)
    }
}
