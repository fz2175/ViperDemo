//
//  ImageDownloadManagerTest.swift
//  ViperDemoTests
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import XCTest
@testable import ViperDemo

class MockImageView: VPImageViewOutputProtocol {
    
    private (set) var didReceiveImage = false
    private (set) var didReceiveError = false
    
    func didReceiveImage(_ image: UIImage) {
        
        didReceiveImage = true
        
    }
    
    func didReceiveError(_ error: String) {
        
        didReceiveError = true
        
    }
    
}

class ImageDownloadManagerTest: XCTestCase {
    
    var downloader: ImageDownloadManager?
    
    override func setUp() {
        
        super.setUp()
        downloader = ImageDownloadManager()
        let mockSession = MockURLSession()
        let bundle = Bundle.init(for: ImageDownloadManagerTest.self)
        let image = UIImage(named: "test.png", in: bundle, compatibleWith: nil)!
        mockSession.nextData = UIImagePNGRepresentation(image)
        let apiConnection = ApiConnection()
        apiConnection.urlSession = mockSession
        apiConnection.output = downloader
        downloader?.apiconnection = apiConnection
        
        
    }
    
    override func tearDown() {
        
        downloader = nil
        super.tearDown()
        
    }
    
    func testDownloadImageSucceed() {
        
        let imageView = MockImageView()
        downloader?.imageView = imageView
        downloader?.downloadImageFrom("http://fakeurl")
        XCTAssert(imageView.didReceiveImage, "should get image")
        
        
    }
    
    func testDownloadImageFail() {
        
        let mockSession = downloader?.apiconnection?.urlSession as! MockURLSession
        mockSession.nextData = nil
        let imageView = MockImageView()
        downloader?.imageView = imageView
        downloader?.downloadImageFrom("http://fakeurl")
        XCTAssert(imageView.didReceiveError, "should get error")
        
    }
    
}
