//
//  VPCellViewModel.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

protocol VPCellViewModelProcotol {
    
    init(_ viperModel: ViperModel)
    func getImageURL() -> String
    func getLevel() -> String
    func isAccessible() -> Bool
    
}

struct VPCellViewModel: VPCellViewModelProcotol {
    
    fileprivate var viperModel: ViperModel
    
    init(_ viperModel: ViperModel) {
        
        self.viperModel = viperModel
        
    }
    
    func getImageURL() -> String {
        
        return viperModel.bg_image_url ?? ""
        
    }
    
    func getLevel() -> String {
        
        return viperModel.level ?? ""
        
    }

    func isAccessible() -> Bool {
        
        return viperModel.accessible ?? false
        
    }
    
}
