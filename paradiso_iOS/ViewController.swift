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
        
        let URL = NSURL(string: "http://vip.video74000.fc2.com/up/201509/02/Y/x/f42d58f0a56736d1/IMO_10M_001.3gp?st=jNLciJ1LqrtjIIQ5GsDntg&e=1441983600")
        if let URL = URL {
            VideoDownloadService.downloadWithURL(URL, destination: { (temporaryURL, response) -> NSURL in
                return temporaryURL
            })
                .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                
                }
                .response { request, response, _, error in
                    
            }
        }
    }
}

