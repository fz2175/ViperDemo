//
//  Constants.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

struct C {
    
    struct Api {
        
        static let domain = "http://somedomain"
        static let service = domain + "/someservice"
        static let apiFetchVipers = service + "/fetchVipers"
        
    }
    
    struct HTTPStatusCode {
        
        static let OK = 200
        static let NoContent = 204
        static let Unauthorized = 401
        
    }
    
    struct Storyboard {
        
        static let vpViewController = "VPViewController"
        static let vpNavViewController = "VPNavViewController"
        static let vpViperCell = "viperCell"
        
    }
    
}
