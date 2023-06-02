//
//  ListCollectionViewDatasource.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 31/05/23.
//

import Foundation
import UIKit

///Implementa métodos de Delegate e DataSource da collectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    ///Retorna a qtd de celulas igual a qtd de elementos no array de produtos
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.products.count
    }
    ///Retorna célula com base nos produtos do array
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell().getIdentifier(), for: indexPath)
        if let pcell = cell as? ProductCollectionCell {
            let item = self.products[indexPath.item]
            let model = viewModelFrom(model: item)
            pcell.setupWith(model: model)
        }
        return cell
    }
    ///Caso houvesse uma tela de detalhes aqui seria onde implementaria o push para tela de detalhes.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Ação de toque para abrir tela de detalhes.
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
    
    ///Método para colocar o Footer na CollectionView, ele tbm é usado para fazer o Header caso fosse nescessario.
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
    
    ///Método para criar o ViewModel da célula com base nas informações do produto.
    func viewModelFrom(model: ProductModel) -> CellViewModel{
        return CellViewModel(name: model.name, url: imageURLs(urlStr: model.image), fullPrice: model.price, discountPrice: model.discountPrice, discount: model.percentDiscount, rating: model.reviewScore, producer: model.producer?.name)
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
