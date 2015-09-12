//
//  VideoFeedsTableViewController.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/12.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import UIKit
import SVWebViewController

class VideoFeedsTableViewController: UITableViewController, UIWebViewDelegate {
    let videofeeds: [String] = [
        "http://jp.xvideos.com/video4234045/an_asian_girl_is_sitting_on_a_bed_playing_with_her_from_http_alljapanese.net",
        "http://video.fc2.com/a/content/20150816e1ZrXrp9&t_aswell",
        "http://asg.to/contentsPage.html?mcd=jZxtyNShVwx7vIaa",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showVideoDownloadAlertController(downloadbleURL: NSURL!) {
        let alertController = UIAlertController(title: "", message: "ダウンロード可能です", preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: "ダウンロード", style: .Default, handler: { action in
            VideoDownloadService.downloadWithURL(downloadbleURL, downloadCompletionHandler: { fileURL, success in
        }).progress {bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print("byte:\(bytesRead) total: \(totalBytesRead) totalExpect: \(totalBytesExpectedToRead)")
        }}))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: {})
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videofeeds.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoFeedsTableViewCell", forIndexPath: indexPath)
        cell.textLabel?.text = videofeeds[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let webViewController = SVWebViewController(URL: NSURL(string: videofeeds[indexPath.row]))
        webViewController.delegate = self
        self.navigationController?.pushViewController(webViewController, animated: true)
    }

    
    // MARK: - UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if VideoDownloadService.downloadableURL(request.URL) {
            showVideoDownloadAlertController(request.URL)
        }
        return !VideoDownloadService.downloadableURL(request.URL)
    }
}
