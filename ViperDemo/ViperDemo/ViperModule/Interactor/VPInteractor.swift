//
//  VPInteractor.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation

protocol VPInteractorInputProtocol {
    
    var apiConnection: ApiConnectionProtocal? { get }
    var presenter: VPPresenterOutputProtocal? { set get }
    func fetchVipers()
    
}

class VPInteractor: VPInteractorInputProtocol {
    
    lazy var apiConnection: ApiConnectionProtocal? = {
        let apiConnection = ApiConnection()
        apiConnection.urlSession = mockURLSession()
        apiConnection.output = self
        return apiConnection
    }()
    weak var presenter: VPPresenterOutputProtocal?

    func fetchVipers() {
        
        let urlStr = C.Api.domain + C.Api.service + C.Api.apiFetchVipers
        apiConnection?.sendRequest(URLRequest(urlStr, .GET))
        
    }
    
}

extension VPInteractor: ApiconnectionOutputProtocal {
    
    func didReceiveData(_ data: Data) {
        
        do {
            let vipersModel = try JSONDecoder().decode(VipersModel.self, from: data)
            presenter?.didReceiveVipers(vipersModel)
        }catch {
            presenter?.didReceiveError(.jsonConversionFailure)
        }
        
    }
    
    func didReceiveError(_ error: CustomizeError) {
        
        presenter?.didReceiveError(error)
        
    }
    
}

//MARK: private
extension VPInteractor {
    
    fileprivate func mockURLSession() -> URLSessionProtocol {
        
        let mockSession = MockURLSession()
        mockSession.setMockJsonData()
        mockSession.setMockResponseTime(1.5)
        return mockSession
        
    }
    
}
