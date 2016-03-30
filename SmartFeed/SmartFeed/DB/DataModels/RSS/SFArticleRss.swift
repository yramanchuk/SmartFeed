//
//  SFArticleRss.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit

class SFArticleRss: SFArticle {
    var link:String?

    override var linkURL: String? {
        get {
            return link
        }
    }
    
    
    override func propertyMapping() -> [(String?, String?)] {
        
        return [("enclosure", nil), ("media:content", nil), ("pubDate", nil), ("description", nil), ("guid", nil)]
    }

}
