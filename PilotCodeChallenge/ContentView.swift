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
    
    @State var showingIntro = true

        var body: some View {
            
            ZStack{
                Color.red
                .edgesIgnoringSafeArea(.all)
            VStack{
              Text("Code Challenge")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)  //.background(Color.green)
                
             MapView(manager: $manager, alert: $alert).alert(isPresented: $alert) {
                         
                         Alert(title: Text("Please Enable Location Access In Settings Pannel !!!"))
                     }
                }
            }.sheet(isPresented: $showingIntro) {
                IntroView()
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
