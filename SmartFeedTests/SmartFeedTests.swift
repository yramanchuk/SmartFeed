//
//  SmartFeedTests.swift
//  SmartFeedTests
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import XCTest
import RealmSwift

@testable import SmartFeed

class SmartFeedTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        isTestMode = true
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDbCRUD() {
        
      // bad idea to mock singleton!
//        class MockModelManager : SFModelManager {
//            override func realm() -> Realm {
//                return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: TEST_MODE))
//            }
//        }
//        let modelManager = MockModelManager.sharedInstance

        let modelManager = SFModelManager.sharedInstance
        
        
        
        let feed = SFFeed()
        
        //test create
        let feedId = modelManager.updateFeedSync(feed)
        XCTAssertEqual(feedId, feed.feedId)
        XCTAssertNotNil(feedId)
        
        //test read
        let foundFeed = modelManager.getFeed(byLink: feed.link)
        XCTAssertNotNil(foundFeed)
        XCTAssertEqual(feedId, foundFeed?.feedId)
        XCTAssertEqual(feed.title, foundFeed?.title)
        XCTAssertEqual(feed.link, foundFeed?.link)
        

//        //test update
//        feed.link = "http://test2.com"
//        let feedIdAfterUpdate = modelManager.updateFeedSync(feed)
//        XCTAssertEqual(feedId, feedIdAfterUpdate)

        //test read
        let allFeeds = modelManager.getAllFeeds()
        XCTAssertTrue(allFeeds.count == 1)
        let feedAfterUpdate = allFeeds.first!
        XCTAssertEqual(feedId, feedAfterUpdate.feedId)  //feed was not changed
        XCTAssertEqual(foundFeed!.link, feedAfterUpdate.link)

        
        //test delete
        let expectation = expectationWithDescription("feed is deleted")
        modelManager.deleteFeedAsync(feedId) { 
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(2) { (error) in
            if error != nil {
                print("Time out deleting feedId \(feedId)")
            }

            let allFeedsEmpty = modelManager.getAllFeeds()
            XCTAssertTrue(allFeedsEmpty.count == 0)

        }
        

        
        
    }
    
    func testPerformanceReadability() {
        // This is an example of a performance test case.
        self.measureBlock {
            let expectation = self.expectationWithDescription("Test html is parsed")
            
            let url = NSURL(fileURLWithPath: NSBundle(forClass: SmartFeedTests.classForCoder()).pathForResource("test", ofType: "html")!)
            let readability = DZReadability.init(URLToDownload: url, options: nil, completionHandler:  { (sender, content, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(content)
                XCTAssertTrue(content.characters.count > 0)
                expectation.fulfill()
            })
            
            readability .start()
            
            self.waitForExpectationsWithTimeout(10, handler: { (error) in
                if error != nil {
                    print("Time out parsing test page \(url)")
                }
            })
            
            XCTAssertNotNil(readability)

            // Put the code you want to measure the time of here.
        }
    }
    
}
