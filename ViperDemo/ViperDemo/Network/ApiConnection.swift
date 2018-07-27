//
//  ApiConnectionProtocal.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

protocol ApiConnectionProtocal {
    
    var urlSession: URLSessionProtocol? { set get }
    var output: ApiconnectionOutputProtocal? {set get}
    func sendRequest(_ request: URLRequest)
    func cancelLastRequest()
    
}

protocol ApiconnectionOutputProtocal: class {
    
    func didReceiveData(_ data: Data)
    func didReceiveError(_ error: CustomizeError)
    
}

class ApiConnection: ApiConnectionProtocal {
    
    var urlSession: URLSessionProtocol?
    weak var output: ApiconnectionOutputProtocal?
    
    private var lastSessionDataTask: URLSessionDataTaskProtocol?
    
    func sendRequest(_ request: URLRequest) {
        
        lastSessionDataTask = urlSession?.testableDataTask(with: request) { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                self?.output?.didReceiveError(.requestFailed)
                return
            }
            if let data = data, httpResponse.statusCode == C.HTTPStatusCode.OK {
                self?.output?.didReceiveData(data)
            }else if httpResponse.statusCode == C.HTTPStatusCode.Unauthorized {
                self?.output?.didReceiveError(.unauthorized)
            }else if httpResponse.statusCode == C.HTTPStatusCode.NoContent{
                self?.output?.didReceiveData(Data())
            }else {
                self?.output?.didReceiveError(.responseUnsuccessful)
            }
        }
        lastSessionDataTask?.resume()
        
    }
    
    func cancelLastRequest() {
        
        guard let lastSessionDataTask = lastSessionDataTask else {
            return
        }
        lastSessionDataTask.cancel()
        
    }
    
}
