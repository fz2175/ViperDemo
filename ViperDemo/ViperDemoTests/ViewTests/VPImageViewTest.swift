//
//  VPImageViewTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class MockCacheManager: ImageCacheManagerProtocol {
    
    var shouldReturnCacheImage = false
    var didCacheImage = false
    var didGetImageFromCache = false
    
    func cacheImageForKey(_ image: UIImage, _ key: String) {
        
        didCacheImage = true
        shouldReturnCacheImage = true
        
    }
    
    func getImageForKey(_ key: String) -> UIImage? {
        
        if shouldReturnCacheImage {
            return UIImage()
        }else {
            return nil
        }
        
    }
    
}

class MockDownloadManager: ImageDownloadManagerProtocol {
    
    var apiconnection: ApiConnectionProtocal?
    weak var imageView: VPImageViewOutputProtocol?
    
    var cancelDidCalled = false
    var shouldReturnError = false
    
    func downloadImageFrom(_ url: String) {
        
        if shouldReturnError {
            imageView?.didReceiveError("")
        }else {
            imageView?.didReceiveImage(UIImage())
        }
        
    }
    
    func cancelDownload() {
        
        cancelDidCalled = true
        
    }
    
}

class VPImageViewTest: XCTestCase {
    
    var imageView: VPImageView?
    
    override func setUp() {
        imageView = VPImageView()
        imageView?.cache = MockCacheManager()
        let downloadManager = MockDownloadManager()
        downloadManager.imageView = imageView
        imageView?.downloader = downloadManager
        super.setUp()
    }
    
    override func tearDown() {
        imageView = nil
        super.tearDown()
    }
    
    func updateToInitialValue() {
        
        let cache = imageView?.cache as! MockCacheManager
        let downloader = imageView?.downloader as! MockDownloadManager
        cache.didCacheImage = false
        cache.shouldReturnCacheImage = false
        downloader.cancelDidCalled = false
        downloader.shouldReturnError = false
        
    }
    
    func testImageDownloadSucceed() {

        updateToInitialValue()
        imageView?.setImageFromURL("http://fake.png")
        XCTAssert(imageView?.image != nil, "image has been downloaded")

    }
    
    func testImageDownloadError() {
        
        updateToInitialValue()
        let downloader = imageView?.downloader as! MockDownloadManager
        downloader.shouldReturnError = true
        XCTAssert(imageView?.image == nil, "image should not exitsts")
        
    }
    
    func testImageDidCache() {
        
        updateToInitialValue()
        imageView?.setImageFromURL("http://fake.png")
        let cache = imageView?.cache as! MockCacheManager
        XCTAssert(cache.didCacheImage, "image has been cached")
        
    }
    
    func testImageDownloadCancel() {
        
        updateToInitialValue()
        imageView?.cancelDownload()
        let downloader = imageView?.downloader as! MockDownloadManager
        XCTAssert(downloader.cancelDidCalled, "cancel must be called")
        
    }
    
    func testGetImageFromCache() {
        
        updateToInitialValue()
        let imageURL = "http://fake.png"
        imageView?.setImageFromURL(imageURL) //this time download from Web
        imageView?.image = nil
        let downloader = imageView?.downloader as! MockDownloadManager
        downloader.shouldReturnError = true
        imageView?.setImageFromURL(imageURL) //this time get image from cache
        XCTAssert(imageView?.image != nil, "image has been downloaded")
        
    }
    
    func testGetImageWithEmptyURL() {
        
        updateToInitialValue()
        imageView?.setImageFromURL("")
        XCTAssert(imageView?.image == nil, "image should not be downloaded")
        
    }
    
}
