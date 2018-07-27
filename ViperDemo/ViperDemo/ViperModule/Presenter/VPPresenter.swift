//
//  VPPresenter.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

protocol VPPresenterInputProtocal {
    
    var interactor: VPInteractorInputProtocol? { set get }
    var vc: VPViewControllerProtocol? { set get }
    func updateVipers()
    
}

protocol VPPresenterOutputProtocal: class {
    
    func didReceiveVipers(_ vipersModel: VipersModel)
    func didReceiveError(_ error: CustomizeError)
    
}

class VPPresenter: VPPresenterInputProtocal {
    
    var interactor: VPInteractorInputProtocol?
    var vpViewModel: VPViewModelProtocol?
    weak var vc: VPViewControllerProtocol?
    func updateVipers() {
        interactor?.fetchVipers()
    }
    
}

extension VPPresenter: VPPresenterOutputProtocal {
    
    func didReceiveVipers(_ vipersModel: VipersModel) {
        
        if Thread.isMainThread {
            vc?.didReceiveVipers(VPViewModel(vipersModel))
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.vc?.didReceiveVipers(VPViewModel(vipersModel))
        }
        
    }
    
    func didReceiveError(_ error: CustomizeError) {
        
        if Thread.isMainThread {
            vc?.didReceiveError(error.localizedDescription)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.vc?.didReceiveError(error.localizedDescription)
        }
        
    }
    
}
