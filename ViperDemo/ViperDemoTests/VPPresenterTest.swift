//
//  VPPresenterTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class MockVPInteractorInput: VPInteractorInputProtocol {
    
    weak var presenter: VPPresenterOutputProtocal?
    var apiConnection: ApiConnectionProtocal?
    private (set) var isTestingSucceed = true
    func fetchVipers() {
        if isTestingSucceed {
            presenter?.didReceiveVipers(VipersModel())
        }else {
            presenter?.didReceiveError(.invalidData)
        }
    }
    
}

class MockVPViewController: VPViewControllerProtocol {
    
    var presenter: VPPresenterInputProtocal?
    var didReceiveData = false
    var didReceiveError = false
    
    func didReceiveVipers(_ viewModel: VPViewModelProtocol) {
        didReceiveData = true
    }
    
    func didReceiveError(_ errorMsg: String) {
        didReceiveError = true
    }
    
}

class VPPresenterTest: XCTestCase {
    
    var presenter: VPPresenter?
    
    override func setUp() {
        
        super.setUp()
        presenter = VPPresenter()
        let interactor = MockVPInteractorInput()
        interactor.presenter = presenter
        presenter?.interactor = interactor
        
    }
    
    override func tearDown() {
        
        presenter = nil
        super.tearDown()
        
    }
    
    func testFetchVipersSucceed() {
        
        let vc = MockVPViewController()
        presenter?.vc = vc
        presenter?.updateVipers()
        XCTAssert(vc.didReceiveData, "MockVPViewController should receive data")
        
    }
    
}
