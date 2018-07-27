//
//  VPMessageView.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

protocol VPMsgViewProtocol {
    
    func showWithMsg(_ msg: String)
    func hide()
    
}

class VPMsgView: UIView {
    
    @IBOutlet weak var msgLabel: UILabel!
    
}

extension VPMsgView: VPMsgViewProtocol {
    
    func showWithMsg(_ msg: String) {
        
        isHidden = false
        msgLabel.text = msg
        
    }
    
    func hide() {
        
        isHidden = true
        
    }
    
}
