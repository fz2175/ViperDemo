//
//  VPMsgViewTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class VPMsgViewTest: XCTestCase {
    
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
        
        guard let view = vc?.msgView else {
            XCTAssert(false, "must have a loading view")
            return
        }
        let msgStr = "test msg"
        view.showWithMsg(msgStr)
        XCTAssert(!view.isHidden, "hidden must be false")
        XCTAssert(view.msgLabel.text == msgStr, "message must be same")
        
    }
    
    func testHide() {
        
        guard let view = vc?.msgView else {
            XCTAssert(false, "must have a loading view")
            return
        }
        view.hide()
        XCTAssert(view.isHidden, "hidden must be true")
        
    }

}
