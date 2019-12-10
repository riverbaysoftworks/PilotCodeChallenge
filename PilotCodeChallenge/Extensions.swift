//
//  Extensions.swift
//  PilotCodeChallenge
//
//  Created by Mark Pruit on 12/7/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import Foundation

//Haversine formula to find differences between annotations and user location if we need it for all locations
func haversine(lat1:Double, lon1:Double, lat2:Double, lon2:Double) -> Double {
    let lat1rad = lat1 * Double.pi/180
    let lon1rad = lon1 * Double.pi/180
    let lat2rad = lat2 * Double.pi/180
    let lon2rad = lon2 * Double.pi/180
 
    let dLat = lat2rad - lat1rad
    let dLon = lon2rad - lon1rad
    let a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1rad) * cos(lat2rad)
    let c = 2 * asin(sqrt(a))
    let R = 6372.8
 
    return R * c
}
 
