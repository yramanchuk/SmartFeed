//
//  SFFeed.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection

class SFFeed: EVObject {

    var entry: [SFArticle] = [SFArticle]()
    var title: String?
    var url: String!
    
    var articles: [SFArticle] {
        get {
            return entry;
        }
    }
    
    override var debugDescription : String {
        return "\(title) \(articles)"
    }
    
    override func propertyMapping() -> [(String?, String?)] {
        return [("__name", nil), ("author", nil), ("_xmlns", nil), ("id", nil), ("subtitle", nil), ("updated", nil), ("link", nil), ("_xmlns:lj", nil), ("lj:journal", nil), ("", nil)]
    }
    
//    override func propertyConverters() -> [(String?, ((Any?)->())?, (() -> Any?)? )] {
//        return [
//            (
//                "articles", {
//                    let arr: NSArray = ($0 as? NSArray)!
//                    self.articles = arr as! [SFArticle];
//                }, {
//                    return self.articles
//                }
//            )
//        ]
//    }


    
}
