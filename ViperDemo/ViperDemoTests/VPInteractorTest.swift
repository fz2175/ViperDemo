//
//  VPInteractorTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class MockVPPresenterOutput: VPPresenterOutputProtocal {
    
    private (set) var didReceiveModel = false
    private (set) var didReceiveError = false
    
    func didReceiveVipers(_ vipersModel: VipersModel) {
        didReceiveModel = true
    }
    
    func didReceiveError(_ error: CustomizeError) {
        didReceiveError = true
    }
    
}

class VPInteractorTest: XCTestCase {
    
    var interactor: VPInteractor?
    
    override func setUp() {
        super.setUp()
        interactor = VPInteractor()
        let apiconnection = ApiConnection()
        apiconnection.urlSession = MockURLSession()
        apiconnection.output = interactor
        interactor?.apiConnection = apiconnection
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }
    
    func testFetchVipersSucceed() {
        
        var apiconnection = interactor?.apiConnection
        let mockSession = MockURLSession()
        mockSession.setMockJsonData()
        apiconnection?.urlSession = mockSession
        let presenter = MockVPPresenterOutput()
        interactor?.presenter = presenter
        interactor?.fetchVipers()
        XCTAssert(presenter.didReceiveModel, "presenter should receive model")
        
    }
    
    func testFetchVipersFails() {
        
        let presenter = MockVPPresenterOutput()
        interactor?.presenter = presenter
        interactor?.fetchVipers()
        XCTAssert(presenter.didReceiveError, "presenter should receive error")
        
    }

}
