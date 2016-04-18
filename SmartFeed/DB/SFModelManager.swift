//
//  SFModelManager.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import RealmSwift

class SFModelManager {
    static let sharedInstance = SFModelManager()
    
    func getAllFeeds() -> [SFFeedProtocol] {

        let realm = self.realm()
        let feeds = realm.objects(SFFeedRealm)

        return Array(feeds)
    }

    func getFeed(feedID: String!) -> SFFeedProtocol? {
        
        let realm = self.realm()
        
        return realm.objectForPrimaryKey(SFFeedRealm.self, key: feedID) as? SFFeedProtocol
    }

    func getFeed(byLink feedUrl: String!) -> SFFeedProtocol? {
        
        let realm = self.realm()
        
        return realm.objects(SFFeedRealm).filter("link == '\(feedUrl)'").first as? SFFeedProtocol
    }

    /// only updates updates feed child articles
    /// this methods must be optimized not to create new feed realm object
    func updateFeedSync(feed: SFFeedProtocol) -> String {
        
        let realm = self.realm()
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
        let realm = self.realm()
        let articles = realm.objects(SFArticleRealm).filter("linkURL == '\(articleUrl)'")
        try! realm.write {
            articles.setValue(isNew, forKeyPath: "isNew")
            realm.add(articles, update: true)
        }
        
    }
    
    
    func deleteFeedAsync(feedID: String!, complitionHandler: (() -> Void)?) -> Void {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let realm = self.realm()

            if let feedRealm = realm.objectForPrimaryKey(SFFeedRealm.self, key: feedID) {
                
                debugPrint("deleting \(feedRealm.title)")
                try! realm.write {
                    realm.delete(feedRealm.articlesDB)
                    realm.delete(feedRealm)
                }
                if complitionHandler != nil {
                    complitionHandler!()
                }
            }
        }
    }
    
    func realm() -> Realm {
        if isTestMode {
            return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: TEST_MODE))
        }
        return try! Realm()
    }

}
