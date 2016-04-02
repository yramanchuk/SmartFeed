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
    var url: String?
    var feedId: String!
    
    
    private(set) var articles: [SFArticleProtocol] = []
    
    override var debugDescription : String {
        return "\(title) \(articles)"
    }
    
    
}
