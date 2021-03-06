//
//  SFArticleAtom.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit

class SFArticleAtom: SFArticle {
    var link:[NSDictionary] = [NSDictionary]()
    
    override var linkURL: String? {
        get {
            for val in link {
                let relVal: String = val.objectForKey("_rel") as! String
                if relVal == "alternate" {
                    return val.objectForKey("_href") as? String!;
                }
            }
            
            return ""
        }
        
        set {}
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
