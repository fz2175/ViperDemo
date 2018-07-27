//
//  VPViewModel.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

protocol VPViewModelProtocol {
    
    init(_ vipersModel: VipersModel)
    func getOverviewTitle() -> String
    func vipersCount() -> Int
    func hasData() -> Bool
    func getCellViewModelFrom(_ index: Int) -> VPCellViewModelProcotol?
    
}

struct VPViewModel: VPViewModelProtocol {
    
    fileprivate var vipersModel: VipersModel
    fileprivate var cellModels: [VPCellViewModelProcotol]
    
    init(_ vipersModel: VipersModel) {
        
        self.vipersModel = vipersModel
        guard let vipers = vipersModel.vipers else {
            cellModels = []
            return
        }
        cellModels = vipers.map{VPCellViewModel($0)}
        
    }
    
}

//MARK: Public
extension VPViewModel {
    
    func getOverviewTitle() -> String {
        
        return self.vipersModel.overview?.title ?? ""
        
    }
    
    func hasData() -> Bool {
        
        return cellModels.count > 0
        
    }
    
    func vipersCount() -> Int {
        
        return vipersModel.vipers?.count ?? 0
        
    }
    
    func getCellViewModelFrom(_ index: Int) -> VPCellViewModelProcotol? {
        
        if index < 0 || index >= cellModels.count {
            return nil
        }
        return cellModels[index]
        
    }
    
}
