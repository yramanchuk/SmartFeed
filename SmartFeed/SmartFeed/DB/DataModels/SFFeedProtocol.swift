//
//  SFFeedProtocol.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/1/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//



@objc protocol SFFeedProtocol {
    var title: String? {get set}
    var url: String? {get set}
    var feedId: String! {get}

    var articles: [SFArticleProtocol] {get}

}
