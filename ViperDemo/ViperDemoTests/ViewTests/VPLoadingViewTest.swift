//
//  VPLoadingViewTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class VPLoadingViewTest: XCTestCase {
    
    var vc: VPViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: C.Storyboard.vpViewController) as? VPViewController
        _ = vc?.view
    }
    
    override func tearDown() {
        vc = nil
        super.tearDown()
    }
    
    func testShow() {
        
        guard let view = vc?.loadingView else {
            XCTAssert(false, "must have a loading view")
            return
        }
        view.show()
        XCTAssert(!view.isHidden, "hidden must be false")
        XCTAssert(view.loadingIndicator.isAnimating, "loadingIndicator must be animating")
        
    }
    
    func testHide() {
        
        guard let view = vc?.loadingView else {
            XCTAssert(false, "must have a loading view")
            return
        }
        view.hide()
        XCTAssert(view.isHidden, "hidden must be true")
        XCTAssert(!view.loadingIndicator.isAnimating, "loadingIndicator must not be animating")
        
    }
    
}
