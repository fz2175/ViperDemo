//
//  ImageCacheManager.swift
//  ViperDemo
//
//  Created by Fan Zhang on 7/27/18.
//  Copyright © 2018 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCacheManagerProtocol {
    
    func cacheImageForKey(_ image: UIImage, _ key: String)
    func getImageForKey(_ key: String) -> UIImage?
    
}

class ImageCacheManager {
    
    static let sharedManager = ImageCacheManager()
    lazy var cache = {
        return NSCache<NSString, UIImage>()
    }()
    
}

extension ImageCacheManager: ImageCacheManagerProtocol {
    
    func cacheImageForKey(_ image: UIImage, _ key: String) {
        
        cache.setObject(image, forKey: key as NSString)
        
    }
    
    func getImageForKey(_ key: String) -> UIImage? {
        
        return cache.object(forKey: key as NSString)
        
    }
    
}
