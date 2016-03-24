//
//  SFFeed.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import Foundation

class SFFeed {
    var articles = [SFArticle]()
    var title: String?
    
    init(aTitle: String) {
        title = aTitle;
        
        //hardcoed initializetion; going to be replaced later
        for i in 0...5 {
            let article = SFArticle(aTitle: "\(title): article \(i)")
            articles.append(article)
        }
        
    }
    
}
