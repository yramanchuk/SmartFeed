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

    func getFeed(feedID: String!) -> SFFeedProtocol? {
        
        let realm = try! Realm()
        
        return realm.objectForPrimaryKey(SFFeedRealm.self, key: feedID) as? SFFeedProtocol
    }

    func getFeed(byLink feedUrl: String!) -> SFFeedProtocol? {
        
        let realm = try! Realm()
        
        return realm.objects(SFFeedRealm).filter("link == '\(feedUrl)'").first as? SFFeedProtocol
    }

    
    func updateFeedSync(feed: SFFeedProtocol) -> String {
        
        let realm = try! Realm()
        var feedId: String!
        
        if let createdFeed = self.getFeed(byLink: feed.link) as! SFFeedRealm! {

            
            try! realm.write {
            
                realm.delete(createdFeed.articlesDB)
                createdFeed.articlesDB.removeAll()
                
                for article in feed.articles {
                    let articleRealm = SFArticleRealm(article: article)
                    createdFeed.articlesDB.append(articleRealm)
                }

                realm.add(createdFeed)
            }
            
            feedId = createdFeed.feedId

        } else {
            let feedRealm = SFFeedRealm(withProtocol: feed)
            
            
            try! realm.write {
                realm.add(feedRealm)
            }
            
            feedId = feedRealm.feedId
        }
        
        
        return feedId
    }
    
    func setReadArticleSync(articleUrl: String, isNew: Bool) -> Void {
        let realm = try! Realm()
        let articles = realm.objects(SFArticleRealm).filter("linkURL == '\(articleUrl)'")
        try! realm.write {
            articles.setValue(isNew, forKeyPath: "isNew")
            realm.add(articles, update: true)
        }
        
    }
    
    
    func deleteFeedAsync(feedID: String!) -> Void {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let realm = try! Realm()

            if let feedRealm = realm.objectForPrimaryKey(SFFeedRealm.self, key: feedID) {
                
                debugPrint("deleting \(feedRealm.title)")
                try! realm.write {
                    realm.delete(feedRealm.articlesDB)
                    realm.delete(feedRealm)
                }
            }
        }
    }

}
