//
//  SFRss.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit
import EVReflection

class SFRss: EVObject {

    var channel: SFFeedRss =  SFFeedRss()
  
    
    override func propertyMapping() -> [(String?, String?)] {
        
        return [("__name", nil), ("_xmlns:media", nil), ("_version", nil), ("_xmlns:atom", nil)]
    }

}
