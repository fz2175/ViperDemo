//
//  CustomizeError.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

enum CustomizeError: Error {
    
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case jsonParsingFailure
    case responseUnsuccessful
    case unauthorized
    case invalidInput
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .unauthorized: return "Unauthorized"
        case .invalidInput: return "Invalid Input"
        }
    }
    
}
