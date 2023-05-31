//
//  ProductsFlowLayout.swift
//
//  Created by Vinicius Soares Lima on 27/03/23.
//

import Foundation
import UIKit

class ProductsFlowLayout: UICollectionViewFlowLayout {
    override init() {
            super.init()
            self.minimumInteritemSpacing = 1
            self.minimumLineSpacing = 1
            self.scrollDirection = .vertical
            self.sectionInset = .zero
        }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Tells the layout object to update the current layout.
    override func prepare() {
        super.prepare()
        if let collectionView = collectionView {
            itemSize = CGSize(width: (collectionView.frame.size.width/2) - 6, height: 275)
        }
    }

    // Asks the layout object if the new bounds require a layout update.
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard itemSize != newBounds.size else { return false }
        itemSize = newBounds.size
        return true
    }
    
}
