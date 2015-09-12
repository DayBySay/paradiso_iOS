//
//  VideoDownloadService.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/11.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import Foundation
import Alamofire

class VideoDownloadService {
    
    static func downloadWithURL(URL: NSURL, destination: (NSURL, NSHTTPURLResponse) -> NSURL) -> Request {
        return Alamofire.download(.GET, URL, destination: destination)
    }
    
    static func downloadableURL(URL: NSURL!) -> Bool {
        return VideoDownloadService.isDownloadable(URL)
    }
    
    static func isDownloadable(URL: NSURL) -> Bool {
        for text in VideoDownloadService.whiteList() {
            if URL.absoluteString.containsString(text) {
                return true
            }
        }
        
        return false
    }
    
     static private func whiteList() -> Array<String> {
        return ["xvideos.com/videos/3gp"]
    }
}