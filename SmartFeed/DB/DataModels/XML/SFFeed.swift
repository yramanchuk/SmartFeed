//
//  SFFeed.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection


class SFFeed: EVObject, SFFeedProtocol {

    var title: String?
    var link: String?
    var feedId: String!
    
    
    private(set) var articles: [SFArticleProtocol] = []
    
    override var debugDescription : String {
        return "\(title) \(articles)"
    }
    
    required init() {
        super.init()
        
        if (isTestMode) {
            self.title = "test title"
            self.feedId = NSUUID().UUIDString
            self.link = "http://test.com"
        }
    }
    
    
}
