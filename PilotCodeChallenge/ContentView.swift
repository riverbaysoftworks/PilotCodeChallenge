//
//  ContentView.swift
//  PilotCodeChallenge
//
//  Created by Mark Pruit on 12/4/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @State var manager = CLLocationManager()
    @State var alert = false

        var body: some View {
            //print(manager.location?.coordinate)
            
            
             MapView(manager: $manager, alert: $alert).alert(isPresented: $alert) {
                         
                         Alert(title: Text("Please Enable Location Access In Settings Pannel !!!"))
                     }

        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
