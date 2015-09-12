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
    @IBOutlet weak var inputURLTextField: UITextField!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func downloadVideoWithURL(URL: NSURL) {
        VideoDownloadService.downloadWithURL(URL, downloadCompletionHandler: { fileURL, success in
        }).progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
            print("byte:\(bytesRead) total: \(totalBytesRead) totalExpect: \(totalBytesExpectedToRead)")
            let rate: Float = Float(totalBytesRead) / Float(totalBytesExpectedToRead)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.progressView.setProgress(rate, animated: true)
            })
        }

    }
    
    @IBAction func touchUpdownloadButton (sender: AnyObject) {
        if let URLString = inputURLTextField.text, URL = NSURL(string: URLString) {
            downloadVideoWithURL(URL)
        }
    }
}