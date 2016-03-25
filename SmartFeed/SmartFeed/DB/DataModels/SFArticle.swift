//
//  SFArticle.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import EVReflection

class Entry: EVObject {
    var Name: String = "entry" // Using the default mapping
    
    var title: String?
//    var url: String?
    var link:[AnyObject] = [AnyObject]()
    
//    init(aTitle: String) {
//        title = aTitle
//    }
//
//    required convenience init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    required convenience init(json: String?) {
//        fatalError("init(json:) has not been implemented")
//    }
//
//    required convenience init(dictionary: NSDictionary) {
//        fatalError("init(dictionary:) has not been implemented")
//    }
//
//    required convenience init(fileNameInTemp: String) {
//        fatalError("init(fileNameInTemp:) has not been implemented")
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
    
    override var description: String {
        return "\(title) \(link)"
    }

    override func setValue(value: AnyObject!, forUndefinedKey key: String) {
        print("\(value) \(key)")
    }
    
    override func propertyMapping() -> [(String?, String?)] {
        return [("id", nil), ("published", nil), ("updated", nil), ("category", nil), ("content", nil)]
    }
    
//    if let (_, propertySetter, _) = (anyObject as? EVObject)?.propertyConverters().filter({$0.0 == key}).first {

    
}