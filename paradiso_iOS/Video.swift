//
//  Video.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/12.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import RealmSwift

class Video: Object {
    dynamic var id: String = NSUUID().UUIDString
    dynamic var URLString = ""
    dynamic var title = ""
    var URL: NSURL? {
        get {
            return NSURL(string: URLString)
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}