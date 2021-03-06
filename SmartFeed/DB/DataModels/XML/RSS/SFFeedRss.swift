//
//  SFFeedRss.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit

class SFFeedRss: SFFeed {

    var item: [SFArticleRss] =  [SFArticleRss]()
 
    override var articles: [SFArticleProtocol] {
        get {
            return item
        }
    }

    override func propertyMapping() -> [(String?, String?)] {
        
        return [("link", nil), ("description", nil)]
    }
    
}
