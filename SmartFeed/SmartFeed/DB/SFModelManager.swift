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
    
    func getAllFeeds() -> [SFFeedProtocol] {

        let realm = try! Realm()
        let feeds = realm.objects(SFFeedRealm)

        return Array(feeds)
    }

    func getFeed(feedID: String!) -> SFFeedProtocol {
        
        let realm = try! Realm()
        
        return realm.objectForPrimaryKey(SFFeedRealm.self, key: feedID) as! SFFeedProtocol
    }

    func updateFeedSync(feed: SFFeedProtocol) -> String {
        
        let realm = try! Realm()
        
        let feedRealm = SFFeedRealm(withProtocol: feed)
        
        try! realm.write {
            realm.add(feedRealm)
        }
        
        return feedRealm.feedId
    }
    
    
    func deleteFeedAsync(feedID: String!) -> Void {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let realm = try! Realm()

            if let feedRealm = realm.objectForPrimaryKey(SFFeedRealm.self, key: feedID) {
                try! realm.write {
                    realm.delete(feedRealm.articlesDB)
                    realm.delete(feedRealm)
                }
            }
        }
    }

}
