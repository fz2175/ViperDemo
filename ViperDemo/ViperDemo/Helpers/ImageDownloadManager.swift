//
//  ImageDownloadManager.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDownloadManagerProtocol {
    
    var apiconnection: ApiConnectionProtocal? { get set }
    var imageView: VPImageViewOutputProtocol? { get set }
    func downloadImageFrom(_ url: String)
    func cancelDownload()
    
}

class ImageDownloadManager: ImageDownloadManagerProtocol {
    
    lazy var apiconnection: ApiConnectionProtocal? = {
        let apiConnection = ApiConnection()
        apiConnection.urlSession = URLSession.shared
        apiConnection.output = self
        return apiConnection
    }()
    weak var imageView: VPImageViewOutputProtocol?
    
    func downloadImageFrom(_ url: String) {
        
        apiconnection?.sendRequest(URLRequest(url, .GET))
        
    }
    
    func cancelDownload() {
        
        apiconnection?.cancelLastRequest()
        
    }
    
}

extension ImageDownloadManager: ApiconnectionOutputProtocal {
    
    func didReceiveData(_ data: Data) {
        
        guard let image = UIImage(data: data) else {
            imageView?.didReceiveError("Fail to convert data to image")
            return
        }
        if Thread.isMainThread {
            imageView?.didReceiveImage(image)
        }else {
            DispatchQueue.main.async { [weak self] in
                self?.imageView?.didReceiveImage(image)
            }
        }
        
    }
    
    func didReceiveError(_ error: CustomizeError) {
        
        imageView?.didReceiveError(error.localizedDescription)
        
    }
    
}
