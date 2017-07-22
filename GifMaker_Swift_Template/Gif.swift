//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by JacobRakidzich on 7/22/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
import Foundation

class Gif /* : NSObject, NSCoding */ {
    
    let url: URL?
    let caption: String?
    let gifImage: UIImage?
    let videoURL: URL?
    let gifData: Data?
    
    /*
    init(url: URL, caption: String, gifImage: UIImage, vidoURL: URL, gifData: Data){
        self.url = url
        self.caption = caption
        self.gifImage = gifImage
        self.videoURL = vidoURL
        self.gifData = gifData
    }
    */
    
    init(url: URL, videoURL: URL, caption: String?) {
        
        self.url = url
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)!
        self.gifData = nil
    }
    
    init(name: String) {
        self.gifImage = UIImage.gif(name: name)
        self.url = nil
        self.videoURL = nil
        self.caption = nil
        self.gifData = nil
    }
    
    
}
