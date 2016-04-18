//
//  SFFeedListTests.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/7/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import KIF

class SFFeedListTests: KIFTestCase {

    var tester : KIFUITestActor {
        get {
            return KIFUITestActor(inFile: #file, atLine: #line, delegate: self)
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresenceOfMyPreciousView() {
//        tester.tapViewWithAccessibilityLabel("add")
    }
    
}
