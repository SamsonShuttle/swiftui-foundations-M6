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
    @Binding var selectedBusiness: Business?
    
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
        mapView.delegate = context.coordinator
        
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
    
    // MARK - Coordinator class
    func makeCoordinator() -> Coordinator {
        
       return Coordinator(map: self)
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // If the annotation is the user blue dot, return nil
            if annotation is MKUserLocation {
                return nil
            }
            
            // Check if theres a reusable annotation view forst
            var annotationsView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationsReuseId)
            
            if annotationsView == nil {
                
                // Create a new onw
                // Create an annotation view
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationsReuseId)
                
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            else {
                // we got a reusable one
                annotationsView!.annotation = annotation
            }
            // Return it
            return annotationsView
        }
     /*
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            
            // user tapped on the annotation view
            
            // Get the business object that this annotation represents
            // Loop through business in the model and find a match
            for business in map.model.restraurants + map.model.sights {
                
                if business.name == view.annotation?.title {
                    
                    // Set the selectedBusiness property to that businss object
                    map.selectedBusiness = business
                    return
                    
                }

            }
            
            // Set the selectedBusiness property to that business object
            
        }*/
        
    }
    
}
