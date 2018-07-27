//
//  String+Extension.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

extension String {
    
    func getFileName() -> String? {
        
        return (self as NSString).lastPathComponent
        
    }
    
}
