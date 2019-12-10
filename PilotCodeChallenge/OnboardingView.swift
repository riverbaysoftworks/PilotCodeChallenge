//
//  OnboardingView.swift
//  SiriDemoSwiftUI
//
//  Created by Mark Pruit on 11/17/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import SwiftUI

struct TestData {
    var id : Int
    var text: String
    var mainImage: String
    var color: Color
}

//let gradientColors = Gradient(colors: [Color.green, Color.orange, Color.green])
//let gradientColors = Gradient(colors: [Color.yellow, Color.pink, Color.yellow])
//let gradientColors = Gradient(colors: [Color.blue, Color.black, Color.blue])

let gradientColors = Gradient(colors: [Color.red, Color.orange, Color.yellow, Color.orange, Color.red,])

struct OnboardingView: View {
    var contentArray: [TestData] = [TestData(id: 0, text: "Just a few simple steps to get started", mainImage: "leaf.arrow.circlepath", color: .green), TestData(id: 1, text: "Check out our privacy and terms of use.", mainImage: "flame.fill", color: .yellow), TestData(id: 2, text: "Fill out tour profile and update it frequently.  It helps keep track of your progress", mainImage: "bolt.fill", color: .blue), TestData(id: 4, text: "Enjoy!", mainImage: "paperplane.fill", color: .white)]

        
        let linearGradient2 = LinearGradient(gradient: gradientColors,            startPoint: .top,             endPoint: .bottom)
        
        
        var body: some View {
          GeometryReader { g in
            Color.white
            .edgesIgnoringSafeArea(.all)
            ZStack{
                SwiftyUIScrollView(axis: .horizontal, numberOfPages: self.contentArray.count, pagingEnabled: true, pageControlEnabled: true, hideScrollIndicators: true) {
                        HStack(spacing: 0) {
                            ForEach(self.contentArray, id: \.id) { item in
                                TestView(data: item)
                                    .frame(width: g.size.width, height: g.size.height)
                            }
                        }
                }.frame(width: g.size.width)
            }.frame(width: g.size.width, height: g.size.height)
                
            }
        }
    }

    struct TestView: View {
        let linearGradient = LinearGradient(gradient: gradientColors,            startPoint: .top,             endPoint: .bottom)
        var data: TestData
        var body: some View {
            
            
            
            GeometryReader { g in
                
                    VStack {
                        
                        HStack {
                            Spacer()
                        }
                        Text("WELCOME!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            
                        //Image(systemName: "cloud.sun.rain.fill")
                       // Image(systemName: "leaf.arrow.circlepath")
                        Image(systemName: self.data.mainImage)
                        .resizable()
                        .frame(width:200.0, height: 200.0)
                            .foregroundColor(self.data.color)
                            .shadow(radius: 4.0)
                            .padding()
                        Text(self.data.text)
                         .fontWeight(.bold)
                      .foregroundColor(.white)
                        .padding()
                        //Text(self.data.text)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    //.background(Color.blue)
                        .background(self.linearGradient)
                .cornerRadius(20)
                .padding()
                        .shadow(radius: 15.0)
            }.background(Color.white)
            //.edgesIgnoringSafeArea(.all)
        }
    }

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
