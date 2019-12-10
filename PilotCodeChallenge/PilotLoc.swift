//
//  PilotLoc.swift
//  PilotCodeChallenge
//
//  Created by Mark Pruit on 12/4/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import Foundation

public struct PilotLoc: Codable {
    public struct Pilot: Codable {
        public let name: String
        public let lat: String
        public let long: String
    }
    public let pilots: [Pilot]
}

