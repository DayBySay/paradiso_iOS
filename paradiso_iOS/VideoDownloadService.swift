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
}