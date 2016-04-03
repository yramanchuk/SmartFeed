//
//  SFArticle.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection

class SFArticle: EVObject, SFArticleProtocol {
    var Name: String = "entry" // Using the default mapping
    
    var title: String?

    var linkURL: String?
    
    var isNew = true
    
    override var debugDescription: String {
        return "\(title) \(linkURL)"
    }

//    override func setValue(value: AnyObject!, forUndefinedKey key: String) {
//        print("\(value) \(key)")
//    }
    
    override func propertyMapping() -> [(String?, String?)] {
        return [("id", nil), ("published", nil), ("updated", nil), ("category", nil), ("content", nil)]
    }
    
}