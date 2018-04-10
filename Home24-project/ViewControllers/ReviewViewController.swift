//
//  ReviewViewController.swift
//  Home24-project
//
//  Created by Dante Puglisi on 4/10/18.
//  Copyright © 2018 Dante Puglisi. All rights reserved.
//

import UIKit
import DisplaySwitcher

private let animationDuration: TimeInterval = 0.3

private let listLayoutStaticCellHeight: CGFloat = 169
private let gridLayoutStaticCellHeight: CGFloat = ((UIScreen.main.bounds.width - 24) / 2) + 6

class ReviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var isTransitionAvailable = true
    fileprivate lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    fileprivate lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid, gridLayoutCountOfColumns: 2)
    
    fileprivate var layoutState: LayoutState = .list
    
    var productArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.collectionViewLayout = listLayout
        collectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"reviewCell")
    }
    
    func switchView(toList: Bool) {
        if !isTransitionAvailable {
            return
        }
        let transitionManager: TransitionManager
        if toList {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: listLayout, layoutState: layoutState)
        } else {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: gridLayout, layoutState: layoutState)
        }
        transitionManager.startInteractiveTransition()
    }
    
    //MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
        if layoutState == .grid {
            cell.setupGridLayout(1)
        } else {
            cell.setupListLayout(1)
        }
        
        cell.setupCell(withProduct: productArray[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTransitionAvailable = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isTransitionAvailable = true
    }

    // MARK: - Actions
    @IBAction func listButtonPressed(_ sender: Any) {
        if layoutState == .grid {
            switchView(toList: true)
        }
    }
    
    @IBAction func gridButtonPressed(_ sender: Any) {
        if layoutState == .list {
            switchView(toList: false)
        }
    }
    
}
