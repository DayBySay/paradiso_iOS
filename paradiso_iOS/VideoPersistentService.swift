//
//  VideoPersistentService.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/12.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import Foundation
import RealmSwift

class VideoPersistentService {
    static func saveVideoWithURL(URL: NSURL, title: String) {
        let video = Video()
        video.title = URL.absoluteString
        video.URLString = URL.absoluteString
        let realm = try! Realm()
        try! realm.write {
            realm.add(video)
        }
    }
}