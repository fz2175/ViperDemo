//
//  VipersModel.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

struct VipersModel: Decodable {
    
    var success: Bool?
    var overview: OverviewModel?
    var vipers: [ViperModel]?
    
}
