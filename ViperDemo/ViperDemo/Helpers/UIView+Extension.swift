//
//  UIView+Extension.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func circleCorner(_ radius: Double) {
        
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
        
    }
    
}
