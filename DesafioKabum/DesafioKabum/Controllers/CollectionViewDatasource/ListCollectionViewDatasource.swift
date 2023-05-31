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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= products.count-1, self.indicator.isAnimating == false, self.stop == false {
            self.caller?.callList(page: ViewController.page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
                
            case UICollectionView.elementKindSectionHeader:
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
                
                headerView.backgroundColor = UIColor.blue
                return headerView
                
            case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
                
                footerView.backgroundColor = UIColor.green
                return footerView
                
            default:
                
                assert(false, "Unexpected element kind")
            }
    }
    
    func configIndicatorConstraintsOn(view: UIView) {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    func imageURLs(urlStr: String) -> URL? {
        let fixUrl = urlStr.replacingOccurrences(of: "http://", with: "https://")
        if let url = URL(string: fixUrl){
        return url
        }
        return nil
    }
}
