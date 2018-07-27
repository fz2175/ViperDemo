//
//  URLRequest+Extension.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}

extension URLRequest {
    
    init(_ urlStr: String, _ httpMethod: HttpMethod, _ payload: Data? = nil) {
        
        self.init(url: URL(string: urlStr)!)
        self.httpMethod = httpMethod.rawValue
        if let payload = payload {
            httpBody = payload
        }

    }
    
}
