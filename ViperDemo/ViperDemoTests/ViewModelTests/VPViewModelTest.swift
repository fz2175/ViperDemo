//
//  VPViewModelTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class VPViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetOverviewTitleHasData() {
        
        let overviewModel = OverviewModel(title: "test title")
        var model = VipersModel()
        model.overview = overviewModel
        let viewModel = VPViewModel(model)
        XCTAssert(viewModel.getOverviewTitle() == "test title", "Overview title must match")
        
    }
    
    func testGetOverviewTitleHasNoData() {
        
        let model = VipersModel()
        let viewModel = VPViewModel(model)
        XCTAssert(viewModel.getOverviewTitle() == "", "Overview title must have no data")
        
    }
    
    func testHasVipersData() {
        
        let viewModel = VPViewModel(fakeVipersModel())
        XCTAssert(viewModel.hasData(), "must have vipers data")
        
    }
    
    func testHasNoVipersData() {
        
        let viewModel = VPViewModel(VipersModel())
        XCTAssert(!viewModel.hasData(), "must not have vipers data")
        
    }
    
    func testVipersCount() {
        
        let viewModel = VPViewModel(fakeVipersModel())
        XCTAssert(viewModel.vipersCount() == 3, "vipers count should be 3")
        
    }
    
    func testGetCellViewModelSucceed() {
        
        let viewModel = VPViewModel(fakeVipersModel())
        XCTAssert(viewModel.getCellViewModelFrom(0) != nil, "must get cell view model")
        
    }
    
    func testGetCellViewModelFail() {
        
        let viewModel = VPViewModel(fakeVipersModel())
        XCTAssert(viewModel.getCellViewModelFrom(-1) == nil, "must not get cell view model")
        XCTAssert(viewModel.getCellViewModelFrom(3) == nil, "must not get cell view model")
        XCTAssert(viewModel.getCellViewModelFrom(4) == nil, "must not get cell view model")
        
    }
    
    private func fakeVipersModel() -> VipersModel {
        
        var model = VipersModel()
        model.vipers = []
        for _ in 0..<3 {
            var viperModel = ViperModel()
            viperModel.accessible = true
            viperModel.level = "1"
            model.vipers?.append(viperModel)
        }
        return model
        
    }
    
}
