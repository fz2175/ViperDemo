//
//  VPViewControllerTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class MockVPPresenterInput: VPPresenterInputProtocal {
    
    var interactor: VPInteractorInputProtocol?
    weak var vc: VPViewControllerProtocol?
    var shouldReceiveData = false
    var shouldReceiveEmptyData = false
    
    func updateVipers() {
        
        if !shouldReceiveData {
            vc?.didReceiveError("error message")
        }else if shouldReceiveEmptyData {
            vc?.didReceiveVipers(VPViewModel(VipersModel()))
        }else {
            vc?.didReceiveVipers(VPViewModel(fakeVipersModel()))
        }
        
    }
    
    private func fakeVipersModel() -> VipersModel {
        
        var model = VipersModel()
        model.vipers = []
        for _ in 0..<3 {
            model.vipers?.append(ViperModel())
        }
        return model
        
    }
    
}

class VPViewControllerTest: XCTestCase {
    
    var vc: VPViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: C.Storyboard.vpViewController) as? VPViewController
    }
    
    override func tearDown() {
        vc = nil
        super.tearDown()
    }
    
    //MARK: test state
    func testInitialState() {
        
        _ = vc?.view
        guard let state = vc?.state else {
            XCTAssert(false, "VPViewController must have a state")
            return
        }
        if case .loading = state {
            XCTAssert(true, "Initial laoding should have state as loading")
        }else {
            XCTAssert(false, "Initial laoding should have state as loading")
        }
        
    }
    
    func testFetchVipersFail() {
        
        let presenter = MockVPPresenterInput()
        vc?.presenter = presenter
        presenter.vc = vc
        _ = vc?.view
        guard let state = vc?.state else {
            XCTAssert(false, "VPViewController must have a state")
            return
        }
        if case .error(_) = state {
            XCTAssert(true, "Fail to load should have state as error")
        }else {
            XCTAssert(false, "Fail to load should have state as error")
        }
        
    }
    
    func testFetchVipersSucceed() {
        
        let presenter = MockVPPresenterInput()
        presenter.shouldReceiveData = true
        vc?.presenter = presenter
        presenter.vc = vc
        _ = vc?.view
        guard let state = vc?.state else {
            XCTAssert(false, "VPViewController must have a state")
            return
        }
        if case .loaded = state {
            XCTAssert(true, "Fail to load should have state as error")
        }else {
            XCTAssert(false, "Fail to load should have state as error")
        }
        XCTAssert(vc?.tableView.dataSource != nil, "table view must have data source when state as loaded")
        
    }
    
    func testFetchVipersNoContents() {
        
        let presenter = MockVPPresenterInput()
        presenter.shouldReceiveData = true
        presenter.shouldReceiveEmptyData = true
        vc?.presenter = presenter
        presenter.vc = vc
        _ = vc?.view
        guard let state = vc?.state else {
            XCTAssert(false, "VPViewController must have a state")
            return
        }
        if case .noData = state {
            XCTAssert(true, "Fail to load should have state as error")
        }else {
            XCTAssert(false, "Fail to load should have state as error")
        }
        
    }
    
    //MARK: test UI for state
    func testLoadingStateUI() {
        
        guard let vc = vc else {
            XCTAssert(false, "Should have a view controller")
            return
        }
        _ = vc.view
        vc.state = .loading
        XCTAssert(!vc.loadingView.isHidden, "Loading view should show when state is loading")
        XCTAssert(vc.tableView.isHidden, "table view should not show when state is loading")
        XCTAssert(vc.msgView.isHidden, "Message view should not show when state is loading")
        
    }
    
    func testLoadedStateUI() {
        
        guard let vc = vc else {
            XCTAssert(false, "Should have a view controller")
            return
        }
        _ = vc.view
        vc.state = .loaded
        XCTAssert(vc.loadingView.isHidden, "Loading view should not show when state is loaded")
        XCTAssert(!vc.tableView.isHidden, "table view should show when state is loaded")
        XCTAssert(vc.msgView.isHidden, "Message view should not show when state is loaded")
        
    }
    
    func testNoDataStateUI() {
        
        guard let vc = vc else {
            XCTAssert(false, "Should have a view controller")
            return
        }
        _ = vc.view
        vc.state = .noData
        XCTAssert(vc.loadingView.isHidden, "Loading view should not show when state is no data")
        XCTAssert(vc.tableView.isHidden, "table view should not show when state is no data")
        XCTAssert(!vc.msgView.isHidden, "Message view should show when state is no data")
        
    }
    
    func testErrorStateUI() {
        
        guard let vc = vc else {
            XCTAssert(false, "Should have a view controller")
            return
        }
        _ = vc.view
        vc.state = .error("")
        XCTAssert(vc.loadingView.isHidden, "Loading view should not show when state is error")
        XCTAssert(vc.tableView.isHidden, "table view should not show when state is no error")
        XCTAssert(!vc.msgView.isHidden, "Message view should show when state is no error")
        
    }
    
}
