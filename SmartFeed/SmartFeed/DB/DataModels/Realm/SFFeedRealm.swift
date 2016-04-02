//
//  SFFeedRealm.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/1/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import RealmSwift

class SFFeedRealm: Object, SFFeedProtocol {
    dynamic var title: String?
    dynamic var url: String?
    
    let articlesDB = List<SFArticleRealm>()
    
    override static func primaryKey() -> String? {
        return "feedId"
    }
    dynamic var feedId: String!

    var articles: [SFArticleProtocol] {
        get {
            return Array(articlesDB)
        }
    }

    convenience init(withProtocol value: SFFeedProtocol) {
        self.init()
        self.title = value.title
        self.url = value.url
        
        if value.feedId != nil {
            self.feedId = value.feedId
        } else {
            self.feedId = NSUUID().UUIDString
        }
        
        for article in value.articles {
            let articleRealm = SFArticleRealm(article: article)
            self.articlesDB.append(articleRealm)
        }
        
    }

}
