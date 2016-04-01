//
//  SFModelManager.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import RealmSwift

class SFModelManager {
    static let sharedInstatnce = SFModelManager()
    

//// 1.    I want to work like this
//    func getAllFeeds() -> [SFFeedProtocol] {
//        
//        let realm = try! Realm()
//        let feeds = realm.objects(SFFeedRealm)
//
//        return Array(feeds)
//    }

    
// 2.
    /*
        This works - see return type
     */
     func getAllFeeds() -> [SFFeedRealm] {
     
     let realm = try! Realm()
     let feeds = realm.objects(SFFeedRealm)
     
     return Array(feeds)
     }
 
  
//// 3.
//    /*
//     even this doesn't work
//     */
//    func getAllFeeds() -> [SFFeedProtocol] {
//        
//        let realm = try! Realm()
//        let feeds = realm.objects(SFFeedRealm)
//        
//        var result = [SFFeedRealm]()
//        for feed in Array(feeds) {
//            result.append(feed)
//        }
//        
//        return result
//    }
    

    
    func updateFeed(feed: SFFeedRealm) -> Void {
        // Get the default Realm
        let realm = try! Realm()
        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(feed)
        }
        
    }
    
}
