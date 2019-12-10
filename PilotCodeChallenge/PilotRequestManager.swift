//
//  PilotRequestManager.swift
//  PilotCodeChallenge
//
//  Created by Mark Pruit on 12/4/19.
//  Copyright © 2019 Mark Pruit. All rights reserved.
//

import Foundation

class PilotRequestManager {
    
    static let shared = PilotRequestManager()
    
    private init(){}
    
    func getLocations(completion: @escaping ([PilotLoc.Pilot]) -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default

        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        guard var URL = URL(string: "https://raw.githubusercontent.com/sicklepilot/pfj-locations/master/locations.json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"

        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                print (data!)
                
                let decoder = JSONDecoder()
                
                let locations = try! decoder.decode([PilotLoc.Pilot].self, from: data!)
                
                print (locations)
                
                completion(locations)
  
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
