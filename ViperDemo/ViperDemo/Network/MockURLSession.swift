//
//  MockURLSession.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

//MARK: Protocols for mock
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func testableDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func testableDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

//MARK: MOCK
class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var responseTime: TimeInterval = 0.0
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func testableDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        if responseTime == 0 {
            completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        }else {
            DispatchQueue.global().asyncAfter(deadline: .now() + responseTime) { [weak self] in
                completionHandler(self?.nextData, self?.successHttpURLResponse(request: request), self?.nextError)
            }
        }
        return nextDataTask
    }
    
}

//Set mock json data
extension MockURLSession {
    
    func setMockJsonData() {
        
        nextData = readJsonFile()
        
    }
    
    func setMockResponseTime(_ time: TimeInterval) {
        
        responseTime = time
        
    }
    
    fileprivate func readJsonFile() -> Data? {
        
        if let path = Bundle.main.path(forResource: "vipers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
        
    }
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    private (set) var cancelWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        cancelWasCalled = true
    }
}
