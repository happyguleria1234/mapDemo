//
//  MarkerStore.swift
//  mapDemo
//
//  Created by Happy Guleria on 11/05/25.
//

import MapKit

struct SavedMarker: Codable {
    var lat: Double
    var long: Double
    var title: String
}

class MarkerStore {
    
    static let shared = MarkerStore()
    
    var markers = [MKAnnotation]()
    
    private init() {}
    
    func addMarker(marker: MKAnnotation) {
        let isMarkerAdded = markers.contains{ exsistMarker in
            exsistMarker.coordinate.latitude == marker.coordinate.latitude && exsistMarker.coordinate.longitude == marker.coordinate.longitude
        }
        
        if isMarkerAdded == false {
            markers.append(marker)
            saveMarkerData()
        }
    }
    
    func saveMarkerData() {
        let savedMarker = markers.map {
            SavedMarker(lat: $0.coordinate.latitude, long: $0.coordinate.longitude, title: (($0.title ?? "") ?? ""))
        }
        
        if let data = try? JSONEncoder().encode(savedMarker) {
            UserDefaults.standard.set(data, forKey: "savedMarkers")
        }
    }
    
    func loadFromDefault() {
        guard let data = UserDefaults.standard.data(forKey: "savedMarkers"),
              let savedMarkers = try? JSONDecoder().decode([SavedMarker].self, from: data) else { return }
        markers = savedMarkers.map { item in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            annotation.title = item.title
            return annotation
        }
    }
    
    func removeMarker(marker: MKAnnotation) {
        markers.removeAll { data in
            data.coordinate.latitude == marker.coordinate.latitude
            && data.coordinate.longitude == marker.coordinate.longitude && data.title == marker.title
        }
        saveMarkerData()
    }
    
}
