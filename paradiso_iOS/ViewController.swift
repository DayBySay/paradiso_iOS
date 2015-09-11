//
//  ViewController.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/11.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let URL = NSURL(string: "http://videos2.cdn.xvideos.com/videos/flv/b/5/7/xvideos.com_b572536347e9f90306e4afa89965d101.flv?e=1441995373&ri=1024&rs=85&h=0168c9a9a556723080558040412e1da9")
        if let URL = URL {
            VideoDownloadService.downloadWithURL(URL, destination: { (temporaryURL, response) -> NSURL in
                let fileManager = NSFileManager.defaultManager()
                let directoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
                if directoryURLs.count == 0 {
                    return temporaryURL
                }
                
                let pathComponent = response.suggestedFilename
                return directoryURLs[0].URLByAppendingPathComponent(pathComponent!)
            }).progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print("byte:\(bytesRead) total: \(totalBytesRead) totalExpect: \(totalBytesExpectedToRead)")
            }.response { request, response, _, error in
                print(response)
            }
        }
    }
}