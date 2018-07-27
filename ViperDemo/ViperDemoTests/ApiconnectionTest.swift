//
//  ApiconnectionTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class MockVPInteractorOutput: ApiconnectionOutputProtocal {
    
    private (set) var dataReceive = false
    private (set) var errorReceive = false
    
    func didReceiveData(_ data: Data) {
        dataReceive = true
    }
    
    func didReceiveError(_ error: CustomizeError) {
        errorReceive = true
    }
    
}

class ApiconnectionTest: XCTestCase {
    
    var apiconnection: ApiConnection?
    
    override func setUp() {
        super.setUp()
        apiconnection = ApiConnection()
        apiconnection?.urlSession = MockURLSession()
    }
    
    override func tearDown() {
        apiconnection = nil
        super.tearDown()
    }
    
    func testGetResumeCalled() {
        
        let dataTask = MockURLSessionDataTask()
        let session = apiconnection?.urlSession as! MockURLSession
        session.nextDataTask = dataTask
        apiconnection?.sendRequest(URLRequest(url: URL(string: "http://mock")!))
        XCTAssert(dataTask.resumeWasCalled, "resume() must be called")
        
    }
    
    func testURLStrSame() {
        
        let url = URL(string: "https://mockurl")!
        let session = apiconnection?.urlSession as! MockURLSession
        apiconnection?.sendRequest(URLRequest(url: url))
        XCTAssertEqual(url, session.lastURL, "the url pass in must be the same as the url called")
        
    }
    
    func testShouldReturnData() {

        let interactor = MockVPInteractorOutput()
        apiconnection?.output = interactor
        let expectedData = "{}".data(using: .utf8)
        let session = apiconnection?.urlSession as! MockURLSession
        session.nextData = expectedData
        apiconnection?.sendRequest(URLRequest(url: URL(string: "http://mock")!))
        XCTAssert(interactor.dataReceive, "should receive data")
        
    }
    
    func testShouldReceiveError() {
        
        let interactor = MockVPInteractorOutput()
        apiconnection?.output = interactor
        apiconnection?.sendRequest(URLRequest(url: URL(string: "http://mock")!))
        XCTAssert(interactor.errorReceive, "should receive error if no data receive")
        
    }
    
    func testRequestCancel() {
        
        let dataTask = MockURLSessionDataTask()
        let session = apiconnection?.urlSession as! MockURLSession
        session.nextDataTask = dataTask
        apiconnection?.sendRequest(URLRequest(url: URL(string: "http://mock")!))
        apiconnection?.cancelLastRequest()
        XCTAssert(dataTask.cancelWasCalled, "resume() must be called")
        
    }
    
}
