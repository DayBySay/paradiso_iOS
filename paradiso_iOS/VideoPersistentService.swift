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
    static func saveVideo(fileName: String, title: String) {
        let video = Video()
        video.title = fileName
        video.URLString = fileName
        let realm = try! Realm()
        try! realm.write {
            realm.add(video)
        }
    }
    
    static func deleteVideoWithID(id: String) {
        let realm = try! Realm()
        let video = realm.objects(Video).filter("id = %@", id)
        
        try! realm.write { ()
            realm.delete(video)
        }
    }
    
    static func fetchAll() -> Results<Video> {
        let realm = try! Realm()
        return realm.objects(Video)
    }
    
    static func fetchAll(completionHandler: (results: Results<Video>) -> Void) {
        let realm = try! Realm()
        completionHandler(results: realm.objects(Video))
    }
}