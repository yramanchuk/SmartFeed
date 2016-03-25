//
//  SFFeed.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection

class SFFeed: EVObject {

    var _name = "feed"
    var entry: [Entry] = [Entry]()
    var title: String?
    var url: String!
    
    var articles: [Entry] {
        get {
            return entry;
        }
    }
//    var Name: String = "" // Using the default mapping
//    var propertyInObject: String = "" // will be written to or read from keyInJson
//    var ignoredProperty: String = "" // Will not be written or read to/from json
//    

    
//    init(aTitle: String, anUrl:String) {
//        title = aTitle;
//        url = anUrl
//        
//        //hardcoed initializetion; going to be replaced later
//        for i in 0...5 {
//            let article = SFArticle()
//            article.title = "\(title): article \(i)"
//            articles.append(article)
//        }
//        
//    }
//    
//    convenience init(aTitle: String) {
//        self.init(aTitle: aTitle, anUrl: "")
//    }

//    override func propertyMapping() -> [(String?, String?)] {
//        return [("articles", "entry")]
//    }

    override func setValue(value: AnyObject!, forUndefinedKey key: String) {
        print("\(value) \(key)")
    }
 
    override var description : String {
        return "\(title) \(articles)"
    }
}
