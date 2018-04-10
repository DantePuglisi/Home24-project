//
//  SelectionViewController.swift
//  Home24-project
//
//  Created by Dante Puglisi on 4/9/18.
//  Copyright © 2018 Dante Puglisi. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift

class SelectionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var swipeableView: ZLSwipeableView!
    
    @IBOutlet weak var reviewButton: UIButton!
    
    // MARK: - Variables
    var productArray = [Product]()
    
    var nextCardCount = 0
    
    var didFinishRating = false
    
    var totalItemsSwiped = 0

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productArray = [Product]()
        nextCardCount = 0
        didFinishRating = false
        totalItemsSwiped = 0
        reviewButton.isEnabled = false
        
        counterLabel.text = "Loading products..."
        reviewButton.isEnabled = false
        swipeableView.alpha = 1.0
        
        APIClient.shared().getData { [weak self] (productArray) in
            guard let strongSelf = self else { return }
            guard let productArray = productArray else { return }
            strongSelf.productArray = productArray
            
            strongSelf.counterLabel.text = "Liked products: 0/\(Constants.totalImages)"
            
            strongSelf.swipeableView.nextView = {
                if strongSelf.nextCardCount == Constants.totalImages {
                    strongSelf.doneLabel.isHidden = false
                    strongSelf.swipeableView.alpha = 1.0
                    return nil
                } else {
                    strongSelf.nextCardCount += 1
                    return strongSelf.nextCardView()
                }
            }
        }
        
        swipeableView.didSwipe = { [weak self] viewSwiped, direction, vector in
            guard let strongSelf = self else { return }
            guard let cardView = viewSwiped as? CardView else  { return }
            
            guard let indexOfProduct = strongSelf.productArray.index(of: cardView.product) else { return }
            
            if direction == .Right {
                strongSelf.productArray[indexOfProduct].liked = true
            } else if direction == .Left {
                strongSelf.productArray[indexOfProduct].liked = false
            }
            
            strongSelf.totalItemsSwiped += 1
            
            strongSelf.counterLabel.text = "Liked products: \(strongSelf.productArray.filter { $0.liked }.count)/\(Constants.totalImages)"
            
            if strongSelf.totalItemsSwiped == Constants.totalImages {
                strongSelf.reviewButton.isEnabled = true
            }
        }
        
    }

    // MARK: - ZLSwipeableView Methods
    func nextCardView() -> UIView? {
        let cardView = CardView(frame: swipeableView.bounds)
        if productArray.count > nextCardCount - 1 {
            cardView.downloadAndShowImage(withProduct: productArray[nextCardCount - 1])
        }
        return cardView
    }
    
    // MARK: - Actions
    @IBAction func thumbsUpPressed(_ sender: Any) {
        swipeableView.swipeTopView(inDirection: .Right)
    }
    
    @IBAction func thumbsDownPressed(_ sender: Any) {
        swipeableView.swipeTopView(inDirection: .Left)
    }
    
    @IBAction func reviewButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let reviewVC = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController {
            reviewVC.productArray = productArray
            navigationController?.pushViewController(reviewVC, animated: true)
        }
    }
}
