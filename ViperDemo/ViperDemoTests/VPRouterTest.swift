//
//  VPRouterTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class VPRouterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRouterGenerateAllElements() {
        
        let navVC = VPRouter.createVPModule()
        XCTAssert(navVC.viewControllers.count > 0, "Navigation view controller must have root view controller")
        guard let vc = navVC.viewControllers.first as? VPViewController else {
            XCTAssert(false, "root view controller must be a VPViewController")
            return
        }
        XCTAssert(vc.presenter != nil, "view must connect a presenter")
        XCTAssert(vc.presenter?.vc != nil, "presenter must connect a view")
        XCTAssert(vc.presenter?.interactor != nil, "presneter must connect a interactor")
        XCTAssert(vc.presenter?.interactor?.presenter != nil, "interactor must connect a presenter")
        
    }
    
}
