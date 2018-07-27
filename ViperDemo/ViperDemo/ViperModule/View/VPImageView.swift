//
//  VPImageView.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

protocol VPImageViewInputProtocol {
    
    var cache: ImageCacheManagerProtocol { get set }
    var downloader: ImageDownloadManagerProtocol { get set }
    func setImageFromURL(_ urlStr: String)
    func cancelDownload()
    
}

protocol VPImageViewOutputProtocol: class {
    
    func didReceiveImage(_ image: UIImage)
    func didReceiveError(_ error: String)
    
}

class VPImageView: UIImageView, VPImageViewInputProtocol {
    
    lazy var cache: ImageCacheManagerProtocol = {
        return ImageCacheManager.sharedManager
    }()
    
    lazy var downloader: ImageDownloadManagerProtocol = {
        let downloader = ImageDownloadManager()
        downloader.imageView = self
        return downloader
    }()
    
    fileprivate let radius = 20.0
    fileprivate var urlStr: String?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        circleCorner(radius)
        
    }
    
    func setImageFromURL(_ urlStr: String) {
        
        self.image = nil
        guard urlStr.count > 0 else {
            return
        }
        if setCacheImageFromURL(urlStr) {
            return
        }
        self.urlStr = urlStr
        downloader.downloadImageFrom(urlStr)
        
    }
    
    func cancelDownload() {
        
        downloader.cancelDownload()
        
    }
    
}

extension VPImageView: VPImageViewOutputProtocol {
    
    func didReceiveImage(_ image: UIImage) {
        
        self.image = image
        cacheImageWithURL(image, urlStr)
        
    }
    
    func didReceiveError(_ error: String) {
        
    }
    
}

//Private
extension VPImageView {
    
    fileprivate func setCacheImageFromURL(_ urlStr: String) -> Bool {
        
        guard let fileName = urlStr.getFileName() else {
            return false
        }
        if let image = cache.getImageForKey(fileName) {
            self.image = image
            return true
        }else {
            return false
        }
        
    }
    
    fileprivate func cacheImageWithURL(_ image: UIImage?, _ urlStr: String?) {
        
        guard let fileName = urlStr?.getFileName(), let image = image else {
            return
        }
        cache.cacheImageForKey(image, fileName)
        
    }
    
}
