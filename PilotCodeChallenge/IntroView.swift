//
//  IntoView.swift
//  PilotCodeChallenge
//
//  Created by Mark Pruit on 12/10/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
            
       ZStack{
               Color.red
           VStack{
               //
               Text("Code Challenge")
                   .fontWeight(.heavy)
               .shadow(radius: 3)
               .padding()
               .background(Color.yellow)
               .foregroundColor(.white)
               .font(.largeTitle)
                   .cornerRadius(25)
                   .padding(.all)
               .shadow(radius: 5)
                   .padding()
               
               Text("\u{2022}" + "  Tap on a pin to reveal the store name. After tapping on the pin you can then tap on ℹ️ to select as your favorite store.\n\u{2022}" + "  You will be alerted when you are within 1000 meters of your favorite location.").foregroundColor(.white)
                   .font(.title) .multilineTextAlignment(.leading).padding()
               
               Text("The app functions better when the phone is not in low power mode or the battery life is low. To use the app in background mode to see when you are near your favorite store, be sure your location setting for the app is set to 'Always'")
                   .foregroundColor(.white)
                   .font(.footnote)
                   .padding()
                   .padding()
               
               
               
               Image(systemName: "square.and.arrow.down.on.square")
               //.foregroundColor(.white)
               .resizable()
                   .frame(width: 60.0, height: 60.0)
                   .scaledToFit()
                   .foregroundColor(.white)
               
               Text("Swipe Down to Dismiss").foregroundColor(.white).padding()
               
               
              }
           }
       }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
