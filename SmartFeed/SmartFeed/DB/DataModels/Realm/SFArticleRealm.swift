//
//  SFArticleRealm.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/1/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import RealmSwift

class SFArticleRealm: Object, SFArticleProtocol {
    dynamic var title: String?
    dynamic var linkURL: String?

    convenience init(article: SFArticleProtocol) {
        self.init()
        self.title = article.title
        self.linkURL = article.linkURL
    }
}
