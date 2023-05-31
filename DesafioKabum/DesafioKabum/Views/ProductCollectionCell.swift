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
    var model: CellViewModel?
    
    
    func setupWith(model: CellViewModel) {
        self.model = model
        imageSetup(url: model.url)
        LabelsSetup()
        setupBackGround()
        setupView()
        setupConstrents()
    }
    
    func setup(name:String, url:URL?, ranking:Int, price:String) {
        imageSetup(url: url)
        nameLabel.text = name
        priceLabel.text = price
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
        ratingLabel.text = model.rating
        configLabels()
    }
    
    func configLabels() {
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 10)
        nameLabel.numberOfLines = 3
        priceLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
        priceLabel.textColor = UIColor(hex: 0x277BBE)
    }
    
    func imageSetup(url: URL?) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
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
    }
    
    func setupConstrents() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 15),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8)
        ])
    }
    
    ///handler
    ///
    func moneyValueString(value: Double) -> String {
        return String(format: "%.2f", value)
    }
}
