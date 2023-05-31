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
            let model = CellViewModel(name: item.name, url: imageURLs(urlStr: item.image), fullPrice: item.price, discountPrice: item.discountPrice, discount: item.percentDiscount, rating: item.reviewScore)
            pcell.setupWith(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    ///Esse método serve para identificar quando estamos para chegar no fim da pagina
    ///aqui verificamos a posição do elemento que vai ser enderizado
    ///Se a posição for a do ultimo produto, então verificamos se o indicador de atividades está ativo. O que indica que já foi feita a chamada e estamos esperando para atualizar a collectionview.
    ///Se ele não estiver ativo, verificamos se a flag stop está ativa. Ela indica que na ultima chamada tivemos um retorno com uma lista vazia de produtos, indicando que não temos mais produtos a exibir e assim impedindo que uma chamada desnecessaria seja feita.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= products.count-1, isLoading() == false, self.stop == false {
            self.caller?.callList(page: ViewController.page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as? IndicatorCollectionFooterView else {
                return UICollectionReusableView()
            }
            footerView.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.indicator.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                self.indicator.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
                ])
            return footerView
        }
        return UICollectionReusableView()
    }
    
    ///Metodo feito com o intuito de resolver possiveis problemas ao gerar uma URL, visto que o sistema prefere urls seguras.(https)
    func imageURLs(urlStr: String?) -> URL? {
        guard let fixUrl = urlStr?.replacingOccurrences(of: "http://", with: "https://") else {
            return nil
        }
        if let url = URL(string: fixUrl){
        return url
        }
        return nil
    }
}
