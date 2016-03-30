//
//  SFFeed.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection


class SFFeed: EVObject {

    var title: String?
    var url: String!
    
    
    private(set) var articles: [SFArticle] = [SFArticle]()
    
    override var debugDescription : String {
        return "\(title) \(articles)"
    }
    
    
}
