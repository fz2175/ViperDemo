//
//  VPCellViewModelTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class VPCellViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasImageURL() {
        
        var model = ViperModel()
        model.bg_image_url = "imageURL"
        let viewModel = VPCellViewModel(model)
        XCTAssert(viewModel.getImageURL() == "imageURL", "Image url must match")
        
    }
    
    func testHasNoImageURL() {
        
        let model = ViperModel()
        let viewModel = VPCellViewModel(model)
        XCTAssert(viewModel.getImageURL() == "", "Image url must be empty")
        
    }
    
    func testHasLevel() {
        
        var model = ViperModel()
        model.level = "1"
        let viewModel = VPCellViewModel(model)
        XCTAssert(viewModel.getLevel() == "1", "level must match")
        
    }
    
    func testHasNoLevel() {
        
        let model = ViperModel()
        let viewModel = VPCellViewModel(model)
        XCTAssert(viewModel.getLevel() == "", "Level must be empty")
        
    }
    
    func testHasIsAccessible() {
        
        var model = ViperModel()
        model.accessible = true
        let viewModel = VPCellViewModel(model)
        XCTAssert(viewModel.isAccessible(), "Accessible must match")
        
    }
    
    func testHasNoAccessible() {
        
        let model = ViperModel()
        let viewModel = VPCellViewModel(model)
        XCTAssert(!viewModel.isAccessible(), "Accessible must be false")
        
    }
    
}
