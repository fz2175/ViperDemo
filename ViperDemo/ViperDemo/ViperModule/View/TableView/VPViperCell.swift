//
//  VPViperCell.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

class VPViperCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: VPImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelBackgroundView: UIView!
    @IBOutlet weak var accessibleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        levelBackgroundView.circleCorner(Double(levelBackgroundView.bounds.width)/2.0)
    }
    
    func updateWith(_ cellViewModel: VPCellViewModelProcotol?) {
        
        guard let cellViewModel = cellViewModel else {
            return
        }
        backgroundImageView.setImageFromURL(cellViewModel.getImageURL())
        levelLabel.text = cellViewModel.getLevel()
        accessibleView.isHidden = cellViewModel.isAccessible()
        
    }
    
    func cellDidEndDisplay() {
        
        backgroundImageView.cancelDownload()
        
    }
    
}
