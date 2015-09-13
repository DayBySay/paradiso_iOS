//
//  VideoDownloadService.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/11.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import Foundation
import Alamofire
import Parse

class VideoDownloadService {
    
    static func downloadWithURL(URL: NSURL, downloadCompletionHandler: ((fileURL: NSURL, success: Bool) -> Void)) -> Request {
        return Alamofire.download(.GET, URL) { (temporaryURL, response) -> NSURL in
            let fileManager = NSFileManager.defaultManager()
            let directoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            if directoryURLs.count == 0 {
                downloadCompletionHandler(fileURL: temporaryURL, success: false)
                return temporaryURL
            }
            
            let fileName = response.suggestedFilename!
            let localURL: NSURL = directoryURLs[0].URLByAppendingPathComponent(fileName)
            VideoPersistentService.saveVideo(fileName, title: fileName)
            downloadCompletionHandler(fileURL: localURL, success: true)
            return localURL
        }
    }
    
    static func downloadableURL(URL: NSURL!) -> Bool {
        return VideoDownloadService.isDownloadable(URL)
    }
    
    static func isDownloadable(URL: NSURL) -> Bool {
        for text in VideoDownloadService.whitelist() {
            if URL.absoluteString.containsString(text) {
                return true
            }
        }
        
        return false
    }
    
     static private func whitelist() -> [String] {
        guard let whitelist = NSUserDefaults.standardUserDefaults().arrayForKey(Key.whitelist.rawValue) else {
            return []
        }
        
        return whitelist as! [String]
    }
    
    static func downloadWhitelist() {
        PFQuery(className: "whitelist").findObjectsInBackgroundWithBlock { results, error in
            let whitelist: [String] = results!.map { (let object: PFObject) -> String in
                let text = object["text"] as! String
                return text
            }
            NSUserDefaults.standardUserDefaults().setObject(whitelist, forKey: Key.whitelist.rawValue)
        }
    }
    
    private enum Key: String {
        case whitelist = "VideoDownloadServiceWhitelist"
    }
    
    // MARK: - local video
    
    static func removeFile(URL: NSURL) {
        let fileManager = NSFileManager.defaultManager()
        try! fileManager.removeItemAtURL(URL)
    }
}