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
    
    func getAllFeeds() -> [SFFeedRealm] {
        //hardcoded to mock data
        
//        var feeds = [SFFeed]()
//        for i in 0...5 {
//            let feed = SFFeed()
//            feed.title = "feed \(i)"
//            feeds.append(feed)
//        }

        let realm = try! Realm()

        let feeds = realm.objects(SFFeedRealm)

        
        return Array(feeds)
    }
    
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
