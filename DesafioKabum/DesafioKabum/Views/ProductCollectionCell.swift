//
//  ProductCollectionCell.swift
//
//  Created by Vinicius Soares Lima on 26/03/23.
//

import Foundation
import UIKit
import SDWebImage

class ProductCollectionCell: UICollectionViewCell {
    let imageView = UIImageView(frame: .zero )
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let oldPriceLabel = UILabel()
    let discount = UILabel()
    let ratingLabel = UILabel()
    let starRatingImg = UIImageView(frame: .zero )
    var model: CellViewModel?
    
    ///Faz o setup quando receber a célula
    func setupWith(model: CellViewModel) {
        self.model = model
        imageSetup(url: model.url)
        LabelsSetup()
        setupBackGround()
        setupView()
        setupConstrents()
    }
    ///Fa o Setup das Labels, colocando os textos nas Labels corretas
    func LabelsSetup() {
        guard let model = self.model else {
            return
        }
        nameLabel.text = model.name
        priceLabel.text = model.fullPrice
        oldPriceLabel.text = model.discountPrice
        discount.text = model.discount
        if let rating = model.rating {
            ratingLabel.text = "\(rating)"
        }
        configLabels()
    }
    ///Configura aparencia das Labels
    func configLabels() {
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 10)
        nameLabel.numberOfLines = 3
        priceLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
        priceLabel.textColor = UIColor(hex: 0x277BBE)
        oldPriceLabel.font = UIFont(name: "Helvetica-Bold", size: 8)
        oldPriceLabel.textColor = .gray
        discount.font = UIFont(name: "Helvetica", size: 10)
        discount.textColor = UIColor(hex: 0xF19D38)
        ratingLabel.font = UIFont(name: "Helvetica-Bold", size: 10)
        ratingLabel.textColor = UIColor(hex: 0xF7CE4B)
        priceLabel.font = UIFont(name: "Helvetica-Bold", size: 10)
        priceLabel.textColor = UIColor(hex: 0x277BBE)
    }
    //Faz o setup das imagens. Sendo uma dinamica vinda da URL e a outra é a imagem da estrela das avaliações
    func imageSetup(url: URL?) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        starRatingImg.translatesAutoresizingMaskIntoConstraints = false
        starRatingImg.contentMode = .scaleAspectFit
        starRatingImg.image = UIImage(named: "star")
    }
    //Configura o fundo da célula, incluindo a curvatura das pontas
    func setupBackGround() {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
    }
    ///Faz a configuração da View, incluindo as labels como subviews e escondendo ou não as labels de preço antigo e disconto com base nos valores.
    ///Se o valor com disconto e valor cheio forem iguais, não tem desconto e assim esses campos devem ser removidos.
    func setupView() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(oldPriceLabel)
        self.contentView.addSubview(discount)
        self.contentView.addSubview(starRatingImg)
        self.contentView.addSubview(ratingLabel)
        oldPriceLabel.isHidden = oldPriceLabel.text == priceLabel.text
        discount.isHidden = oldPriceLabel.text == priceLabel.text
    }
    //Configura as constraints
    func setupConstrents() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        oldPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        discount.translatesAutoresizingMaskIntoConstraints = false
        starRatingImg.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        constraints.append(contentsOf: setupConstraintImageView())
        constraints.append(contentsOf: setupConstraintNameLabel())
        constraints.append(contentsOf: setupConstraintPriceLabel())
        constraints.append(contentsOf: setupConstraintOldPriceLabel())
        constraints.append(contentsOf: setupConstraintRatingLabel())
        constraints.append(contentsOf: setupConstraintStarRatingImg())
        constraints.append(contentsOf: setupConstraintsDiscount())
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupConstraintImageView() -> [NSLayoutConstraint] {
        return [imageView.topAnchor.constraint(equalTo: topAnchor),
         imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
         imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)]
        
    }
    
    func setupConstraintNameLabel() -> [NSLayoutConstraint] {
        return [nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
         nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
         nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)]
    }
    
    func setupConstraintPriceLabel() -> [NSLayoutConstraint] {
        return [priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 15),
         priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
         priceLabel.rightAnchor.constraint(equalTo: discount.leftAnchor, constant: -8),
         priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
         priceLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -60)]
    }
    
    func setupConstraintOldPriceLabel() -> [NSLayoutConstraint] {
        return [oldPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),
         oldPriceLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),]
    }
    
    func setupConstraintRatingLabel() -> [NSLayoutConstraint] {
        return [ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
         ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
         ratingLabel.widthAnchor.constraint(equalToConstant: 15),
         ratingLabel.heightAnchor.constraint(equalToConstant: 15)]
    }
    
    func setupConstraintStarRatingImg() -> [NSLayoutConstraint] {
        return [starRatingImg.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
         starRatingImg.rightAnchor.constraint(equalTo: ratingLabel.leftAnchor),
         starRatingImg.widthAnchor.constraint(equalTo: ratingLabel.widthAnchor, multiplier: 1),
         starRatingImg.topAnchor.constraint(equalTo: ratingLabel.topAnchor)]
    }
    
    func setupConstraintsDiscount() -> [NSLayoutConstraint] {
        return [discount.rightAnchor.constraint(equalTo: starRatingImg.leftAnchor),
         discount.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor)]
    }
}

extension ProductCollectionCell: CellProtocol {
    ///só pra conformar com o protocolo, pois ele facilita receber o identifier para registro na collectionView.
}
