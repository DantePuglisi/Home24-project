//
//  Product.swift
//  Home24-project
//
//  Created by Dante Puglisi on 4/10/18.
//  Copyright © 2018 Dante Puglisi. All rights reserved.
//

import Foundation

struct Product: Equatable {
    var imageURL: URL! = nil
    var title: String! = nil
    var sku: String! = nil
    
    var liked: Bool = false
    
    init(withJSON jsonReceived: [String: AnyObject]) {
        guard let mediaArray = jsonReceived["media"] as? [[String: AnyObject]] else { return }
        
        guard let mediaURLString = mediaArray[0]["uri"] as? String else { return }
        imageURL = URL(string: mediaURLString)
        
        guard let titleString = jsonReceived["title"] as? String else { return }
        title = titleString
        
        guard let skuString = jsonReceived["sku"] as? String else { return }
        sku = skuString
    }
    
    // Equatable
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.sku == rhs.sku
    }
}
