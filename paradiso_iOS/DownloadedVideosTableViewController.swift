//
//  DownloadedVideosTableViewController.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/12.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import UIKit
import RealmSwift
import KRVideoPlayer
import PageMenu

class DownloadedVideosTableViewController: UITableViewController, ParadisoPageMenuDelegate {
    lazy var videoController = KRVideoPlayerController(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
    
    var videos: Results<Video> {
        get {
            return VideoPersistentService.fetchAll()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = video.title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let video = videos[indexPath.row]
        videoController.contentURL = video.URL
        videoController.showInWindow()
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let video = videos[indexPath.row]
            if let URL = video.URL {
                VideoDownloadService.removeFile(URL)                
            }
            VideoPersistentService.deleteVideoWithID(video.id)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func menuTitle() -> String {
        return self.tableView.editing ? "Done" : "Edit"
    }
    
    func pageMenu(pageMenu: CAPSPageMenu, didTouchUpRightBarButton: UIBarButtonItem) -> String? {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
        return self.tableView.editing ? "Done" : "Edit"
    }
}
