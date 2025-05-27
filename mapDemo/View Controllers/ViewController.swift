//
//  ViewController.swift
//  mapDemo
//
//  Created by Happy Guleria on 11/05/25.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var annotations = [MKAnnotation]()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        mapView.delegate = self
        MarkerStore.shared.loadFromDefault()
        NotificationCenter.default.addObserver(self, selector: #selector(updateMap), name: NSNotification.Name(rawValue: "MarkerUpdated"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.addAnnotations(MarkerStore.shared.markers)
    }
    
    @objc func updateMap() {
        loadSavedMarker()
        MarkerStore.shared.loadFromDefault()
    }
    
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handelTap(sender:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handelTap(sender: UITapGestureRecognizer) {
        let gestureLocation = sender.location(in: mapView)
        let cordinate = mapView.convert(gestureLocation, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = cordinate
        MarkerStore.shared.addMarker(marker: annotation)
        loadSavedMarker()
    }
    
    func loadSavedMarker() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(MarkerStore.shared.markers)
    }
    
}

