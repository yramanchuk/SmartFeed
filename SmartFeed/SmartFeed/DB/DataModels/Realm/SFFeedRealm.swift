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
    
//    var articles = [SFArticleProtocol]()
    var articles: [SFArticleProtocol] {
        get {
            var result = [SFArticleProtocol]()
            for article in articlesDB {
                if let obj = article as? SFArticleProtocol {
                    result += [obj]
                }
            }
            return result;
        }
    }
    
    convenience init(withProtocol value: SFFeedProtocol) {
        self.init()
        self.title = value.title
        self.url = value.url
        
        for article in value.articles {
//            self.articles += [SFArticleRealm(article: article) as SFArticleProtocol]
            let articleRealm = SFArticleRealm(article: article)
            self.articlesDB.append(articleRealm)
        }
        
    }

}
