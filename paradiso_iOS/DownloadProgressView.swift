//
//  DownloadProgressView.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/13.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import UIKit

class DownloadProgressView: UIView {

    typealias DownloadCompletionHandler = (() -> Void)?
    
    @IBOutlet weak var progressView: UIProgressView!
    var completionHandler: DownloadCompletionHandler = nil
    
    static func showInView(view: UIView, completionHandler: DownloadCompletionHandler) {
        let progressView = UINib(nibName: "DownloadProgressView", bundle: nil).instantiateWithOwner(self, options: nil).first as! DownloadProgressView
        progressView.frame = CGRectMake(0, CGRectGetHeight(view.frame) - CGRectGetHeight(progressView.frame), CGRectGetWidth(view.frame), CGRectGetHeight(progressView.frame))
        view.addSubview(progressView)
    }
}
