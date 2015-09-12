//
//  ViewController.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/11.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func downloadVideoWithURL(URL: NSURL) {
        VideoDownloadService.downloadWithURL(URL, destination: { (temporaryURL, response) -> NSURL in
            let fileManager = NSFileManager.defaultManager()
            let directoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            if directoryURLs.count == 0 {
                return temporaryURL
            }
            
            let pathComponent = response.suggestedFilename
            let localURL: NSURL = directoryURLs[0].URLByAppendingPathComponent(pathComponent!)
            
            let video = Video()
            video.title = URL.absoluteString
            video.URLString = localURL.absoluteString
            let realm = try! Realm()
            try! realm.write {
                realm.add(video)
            }
            
            return localURL
        }).progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
            print("byte:\(bytesRead) total: \(totalBytesRead) totalExpect: \(totalBytesExpectedToRead)")
        }

    }
}