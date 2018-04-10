//
//  CardView.swift
//  Home24-project
//
//  Created by Dante Puglisi on 4/10/18.
//  Copyright © 2018 Dante Puglisi. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class CardView: UIView {
    
    var imageView = UIImageView()
    
    var product: Product!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
        
        clipsToBounds = true
        
        // Image
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func downloadAndShowImage(withProduct productReceived: Product) {
        product = productReceived
        imageView.af_setImage(withURL: product.imageURL)
    }
}

