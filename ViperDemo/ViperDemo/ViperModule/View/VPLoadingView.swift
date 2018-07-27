//
//  VPLoadingView.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

protocol VPLoadingViewProtocol: class {
    
    func show()
    func hide()
    
}

class VPLoadingView: UIView {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
}

//Public
extension VPLoadingView: VPLoadingViewProtocol {
    
    func show() {
        
        isHidden = false
        loadingIndicator.startAnimating()
        
    }
    
    func hide() {
        
        isHidden = true
        loadingIndicator.stopAnimating()
        
    }
    
}
