//
//  VPVipersDataSource.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class VPVipersDataSourceTest: XCTestCase {
    
    var dataSource: VPVipersDataSource?
    var vc: VPViewController?
    
    override func setUp() {
        super.setUp()
        dataSource = VPVipersDataSource()
        dataSource?.vpViewModel = VPViewModel(fakeVipersModel())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: C.Storyboard.vpViewController) as? VPViewController
        _ = vc?.view
        vc?.tableView.dataSource = dataSource
        vc?.tableView.reloadData()
    }
    
    override func tearDown() {
        dataSource = nil
        vc = nil
        super.tearDown()
    }
    
    func testNumberOfRows() {
        
        let number = dataSource?.tableView(vc!.tableView, numberOfRowsInSection: 0)
        XCTAssert(number == 3, "mock data has 3 vipers")
        
    }
    
    func testTableViewCellData() {
        
        let cell = dataSource?.tableView(vc!.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! VPViperCell
        XCTAssert(cell.levelLabel.text == "1", "level is 1")
        
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
