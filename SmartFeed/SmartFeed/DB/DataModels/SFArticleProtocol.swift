//
//  SFArticleProtocol.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/1/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

@objc protocol SFArticleProtocol {
    var title: String? {get set}
    var linkURL: String? {get set}
    var isNew: Bool {get set}
}