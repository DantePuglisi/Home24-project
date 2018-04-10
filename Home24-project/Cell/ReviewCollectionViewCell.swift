//
//  ReviewCollectionViewCell.swift
//  Home24-project
//
//  Created by Dante Puglisi on 4/10/18.
//  Copyright © 2018 Dante Puglisi. All rights reserved.
//

import UIKit
import DisplaySwitcher
import Alamofire
import AlamofireImage

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!
    
    var product: Product!
    
    func setupCell(withProduct productReceived: Product) {
        product = productReceived
        
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = product.liked ? UIColor(red: 0/255.0, green: 177/255.0, blue: 106/255.0, alpha: 1.0).cgColor : UIColor(red: 239/255.0, green: 72/255.0, blue: 54/255.0, alpha: 1.0).cgColor
        
        imageView.af_setImage(withURL: product.imageURL)
        titleLabel.text = product.title
    }
    
    func setupGridLayout(_ transitionProgress: CGFloat) {
        titleLabel.alpha = 0.0
        labelLeadingConstraint.constant = 0
        labelTrailingConstraint.constant = 0
    }
    
    func setupListLayout(_ transitionProgress: CGFloat) {
        if transitionProgress < 1.0 {
            titleLabel.alpha = 0.0
        } else {
            labelLeadingConstraint.constant = 16
            labelTrailingConstraint.constant = 16
            titleLabel.alpha = 1.0
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? DisplaySwitchLayoutAttributes {
            if attributes.transitionProgress > 0 {
                if attributes.layoutState == .grid {
                    setupGridLayout(attributes.transitionProgress)
                } else {
                    setupListLayout(attributes.transitionProgress)
                }
            }
        }
    }
}
