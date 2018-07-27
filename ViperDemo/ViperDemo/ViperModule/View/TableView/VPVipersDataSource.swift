//
//  VPVipersDataSource.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

class VPVipersDataSource: NSObject {
    
    var vpViewModel: VPViewModelProtocol?
    
}

extension VPVipersDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vpViewModel?.vipersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.Storyboard.vpViperCell) as! VPViperCell
        cell.updateWith(vpViewModel?.getCellViewModelFrom(indexPath.row))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? VPViperCell else {
            return
        }
        cell.cellDidEndDisplay() //cancel download if cell disappear
        
    }
    
}
