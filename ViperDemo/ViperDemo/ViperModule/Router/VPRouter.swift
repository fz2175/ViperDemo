//
//  VPRouter.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

protocol VPRouterProtocol {
    
    static func createVPModule() -> UINavigationController
    
}

class VPRouter: VPRouterProtocol {
    
    static var mainstoryboard: UIStoryboard {
        
        return UIStoryboard(name:"Main",bundle: Bundle.main)
        
    }
    
    class func createVPModule() -> UINavigationController {
        
        let navVC = mainstoryboard.instantiateViewController(withIdentifier: C.Storyboard.vpNavViewController) as! UINavigationController
        let vc = navVC.viewControllers.first! as! VPViewController
        var presenter: VPPresenterInputProtocal & VPPresenterOutputProtocal = VPPresenter()
        var interactor: VPInteractorInputProtocol = VPInteractor()
        vc.presenter = presenter
        presenter.vc = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        return navVC
        
    }
    
}
