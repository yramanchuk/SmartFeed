//
//  Constants.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/31/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

struct FeedType {
    static let kRSS = "rss"
    static let kAtom = "atom"
}
let TEST_MODE = "TEST"
let isTestMode = NSProcessInfo.processInfo().arguments.contains(TEST_MODE)
//let isTestMode = NSProcessInfo.processInfo().environment["-testMode"] != nil
