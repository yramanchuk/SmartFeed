//
//  SFModelManager.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import Foundation

class SFModelManager {
    static let sharedInstatnce = SFModelManager()
    
    func getAllFeeds() -> [SFFeed] {
        //hardcoded to mock data
        
        var feeds = [SFFeed]()
        for i in 0...5 {
            let feed = SFFeed(aTitle: "feed \(i)")
            feeds.append(feed)
        }

        return feeds
    }
    
}
