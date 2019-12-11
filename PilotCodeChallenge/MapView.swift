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
    @Binding var favStoreAlert: Bool

    @State var favLat = 36.0075
    @State var favLong = -84.0278
    

    let map = MKMapView()
    
    func makeCoordinator() -> MapView.Coordinator {
        
        //get the saved favorite store Lat and Long
        let defaults = UserDefaults.standard
        favLat = defaults.object(forKey: "Lat") as? Double ?? 36.0075
        favLong = defaults.object(forKey: "Long") as? Double ?? -84.0278
        
        print ("\(favLat) , \(favLong)")
        
        
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
        
        
       
        //Grab the store locations
       _ = PilotRequestManager.shared.getLocations(completion: {locations in

               print (locations)
        
               for location in locations {
                   
                let annotation = MKPointAnnotation()
                annotation.title = location.name
                annotation.subtitle = "Pilot"
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.lat) ?? 0.0, longitude: Double(location.long) ?? 0.0)
                self.map.addAnnotation(annotation)
               }
       
           })
       
        return map
    }
    
    
   func updateUIView(_ uiView: MKMapView, context: Context) {
    
    let coordinates = manager.location!.coordinate
          
          print (coordinates)
        
          let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
           
           map.region = region
    
           //Your coordinates go here (lat, lon)
           //let geofenceRegionCenter = CLLocationCoordinate2D(latitude: 36.0075, longitude: -83.976)
           
           //Your coordinates go here (lat, lon)
           //let geofenceRegionCenter = CLLocationCoordinate2D(latitude: 36.0075, longitude: -84.0278)
           
           //Favorite store coordinates
           let geofenceRegionCenter = CLLocationCoordinate2D(latitude: favLat, longitude: favLong)
     
           // Create a region
           let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,radius: 1000,identifier: "MyPilot")
           
           geofenceRegion.notifyOnEntry = true
           geofenceRegion.notifyOnExit = true
           
           manager.startMonitoring(for: geofenceRegion)
          
           print (geofenceRegion)
 
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
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
           return view
       }
        
        
       
       func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
           print(mapView.centerCoordinate)
           
       }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            let favStore = view.annotation
            let name = favStore?.title as! String
            let lat = favStore?.coordinate.latitude
            let long = favStore?.coordinate.longitude
            
            print (name)
            print (lat!)
            print (long!)
            
            
            //let's update our favorite store now
            parent.favLat = lat!
            parent.favLong = long!
            
            //And save it to UserDefaults
            let defaults = UserDefaults.standard
            defaults.set(parent.favLat, forKey: "Lat")
            defaults.set(parent.favLong, forKey: "Long")
           
            //let them know favorite store changed
            parent.favStoreAlert.toggle()

        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            switch status {
                
                case .notDetermined, .restricted, .denied:
                        print("No access")
                        parent.alert.toggle()
                case .authorizedAlways, .authorizedWhenInUse:
                        print("Access")
                @unknown default:
                    print ("Unknown Error")
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

