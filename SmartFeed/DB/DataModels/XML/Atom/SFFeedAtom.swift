//
//  SFFeedAtom.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit

class SFFeedAtom: SFFeed {
    var entry: [SFArticleAtom] = [SFArticleAtom]()
    
    override var articles: [SFArticleProtocol] {
        get {
            return entry;
        }
    }
    
    
    override func propertyMapping() -> [(String?, String?)] {
        return [("__name", nil), ("author", nil), ("_xmlns", nil), ("id", nil), ("subtitle", nil), ("updated", nil), ("link", nil), ("_xmlns:lj", nil), ("lj:journal", nil), ("", nil)]
    }

}
