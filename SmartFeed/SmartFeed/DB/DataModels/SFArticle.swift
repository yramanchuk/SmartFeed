//
//  SFArticle.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection

class SFArticle: EVObject {
    var Name: String = "entry" // Using the default mapping
    
    var title: String?
//    var content: String?
    var link:[NSDictionary] = [NSDictionary]()

    var linkURL: String? {
        get {
            for val in link {
                let relVal: String = val.objectForKey("_rel") as! String
                if relVal == "alternate" {
                    return val.objectForKey("_href") as? String;
                }
            }
            
            return ""
        }
    }
    
    
    override var debugDescription: String {
        return "\(title) \(linkURL)"
    }

//    override func setValue(value: AnyObject!, forUndefinedKey key: String) {
//        print("\(value) \(key)")
//    }
    
    override func propertyMapping() -> [(String?, String?)] {
        return [("id", nil), ("published", nil), ("updated", nil), ("category", nil), ("content", nil)]
    }
    
//    override func propertyConverters() -> [(String?, ((Any?)->())?, (() -> Any?)? )] {
//        return [
//            (
//                "link", {
//                    let arr: Array<NSDictionary> = ($0 as? Array<NSDictionary>)!
//                    for val in arr {
//                        let relVal: String = val.objectForKey("_rel") as! String
//                        if relVal == "alternate" {
//                            self.link = val.objectForKey("_href") as? String;
//                        }
//                    }
//                }, {
//                    return self.link
//                }
//            )
//        ]
//    }
}