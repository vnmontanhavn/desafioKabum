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
    
    
    func setupWith(model: CellViewModel) {
        self.model = model
        imageSetup(url: model.url)
        LabelsSetup()
        setupBackGround()
        setupView()
        setupConstrents()
    }
    
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
    
    func imageSetup(url: URL?) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        starRatingImg.translatesAutoresizingMaskIntoConstraints = false
        starRatingImg.contentMode = .scaleAspectFit
        starRatingImg.image = UIImage(named: "star")
    }
    
    func setupBackGround() {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
    }
    
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
    
    func setupConstrents() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        oldPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        discount.translatesAutoresizingMaskIntoConstraints = false
        starRatingImg.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 15),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: discount.leftAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
            priceLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -60),
            oldPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),
            oldPriceLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            ratingLabel.widthAnchor.constraint(equalToConstant: 15),
            ratingLabel.heightAnchor.constraint(equalToConstant: 15),
            starRatingImg.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            starRatingImg.rightAnchor.constraint(equalTo: ratingLabel.leftAnchor),
            starRatingImg.widthAnchor.constraint(equalTo: ratingLabel.widthAnchor, multiplier: 1),
            starRatingImg.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            discount.rightAnchor.constraint(equalTo: starRatingImg.leftAnchor),
            discount.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor)
        ])
    }
    
    ///handler
    ///
    func moneyValueString(value: Double) -> String {
        return String(format: "%.2f", value)
    }
}

extension ProductCollectionCell: CellProtocol {
    //só pra conformar com o protocolo
}
