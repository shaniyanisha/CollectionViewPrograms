//
//  CollectionViewCell.swift
//  Collection&ListButton
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewFlowLayout {
    // here you can define the height of each cell
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 3pt distance between each cell and 3pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 3
        minimumLineSpacing = 3
        scrollDirection = .horizontal
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    //func itemWidth() -> CGFloat {
      //  return (collectionView!.frame.width/2)-1
    //}
    
            override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:150,height: 120)
        }
        get {
            return CGSize(width:150,height: 120)        }
    }
    
       override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
                    return collectionView!.contentOffset
    }
                }
