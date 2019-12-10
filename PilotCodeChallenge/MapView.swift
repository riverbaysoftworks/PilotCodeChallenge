//
//  MapView.swift
//  PilotCodeChallenge
//
//  Created by Mark Pruit on 12/4/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView : UIViewRepresentable {
    
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    let map = MKMapView()
    
    func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.delegate = context.coordinator
        
        manager.requestAlwaysAuthorization()
        //manager.requestWhenInUseAuthorization()
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
    manager.startMonitoringSignificantLocationChanges()
        
        
       print (manager.location!.coordinate)
       
       let coordinates = manager.location!.coordinate
       
       print (coordinates)
     
       let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        map.region = region
 
        //Your coordinates go here (lat, lon)
        //let geofenceRegionCenter = CLLocationCoordinate2D(latitude: 36.0075, longitude: -83.976)
        
        //Your coordinates go here (lat, lon)
        let geofenceRegionCenter = CLLocationCoordinate2D(latitude: 36.0075, longitude: -84.0278)
        
        /*
        //let geofenceRegionCenter = CLLocationCoordinate2D(
            //latitude: 37.33233141,
            //longitude: -122.0312186
            latitude: 35.983281,
            longitude: -83.989134
        )*/


        // Create a region
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,radius: 1000,identifier: "MyPilot")
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        manager.startMonitoring(for: geofenceRegion)
       
        print (geofenceRegion)
  
       //Add Pilot annotations
       _ = PilotRequestManager.shared.getLocations(completion: {locations in
               
               print (locations)
               
               for location in locations {
                   
                let annotation = MKPointAnnotation()
                annotation.title = location.name
                annotation.subtitle = "Pilot"
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.lat)!, longitude: Double(location.long)!)
                self.map.addAnnotation(annotation)
               }
       
           })
       
        return map
    }
   func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject,CLLocationManagerDelegate, MKMapViewDelegate{
        
        var parent : MapView
        
        init(parent1 : MapView) {
            
            parent = parent1
        }
       
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if annotation is MKUserLocation { return nil }
           let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
           view.canShowCallout = true
           return view
       }
       
       func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
           print(mapView.centerCoordinate)
           
       }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied{
                
                parent.alert.toggle()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let location = locations.last
            let point = MKPointAnnotation()
            
           /*
            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!) { (places, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.parent.map.region = region
            }*/
        }   
    }
}

