//
//  ListCollectionViewDatasource.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 31/05/23.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell().getIdentifier(), for: indexPath)
        if let pcell = cell as? ProductCollectionCell {
            let item = self.products[indexPath.item]
            pcell.setup(name: item.name ?? "", url: imageURLs(urlStr: item.image ?? ""), ranking: item.reviewScore ?? 0 , price: item.price ?? "")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func imageURLs(urlStr: String) -> URL? {
        let fixUrl = urlStr.replacingOccurrences(of: "http://", with: "https://")
        if let url = URL(string: fixUrl){
        return url
        }
        return nil
    }
}
