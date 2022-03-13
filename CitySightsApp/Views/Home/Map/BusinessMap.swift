//
//  BusinessMap.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 13/03/2022.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var location:[MKAnnotation] {
        
        var annotations = [MKPointAnnotation]()
        // Create a set of annotations from out list of business
        for business in model.restraurants + model.sights {
            
            // If the business has a lat/long, create an MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            
                // Create a new annotations
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO: Set the region
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotaions
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the business
        // uiView.addAnnotations(self.location)
        uiView.showAnnotations(self.location, animated: true)
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
        
    }
    
}
