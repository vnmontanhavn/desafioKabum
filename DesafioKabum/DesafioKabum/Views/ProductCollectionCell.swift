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
    let producerLabel = UILabel()
    let installmentLabel = UILabel()
    let buyButtom = UIButton()
    let likeButton = UIButton()
    let cartButton = UIButton()
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
        priceLabel.text = model.discountPrice
        producerLabel.text = model.producer
        installmentLabel.text = "\(model.fullPrice ?? "") em até 10x"
        buyButtom.setTitle("Comprar", for: .normal)
        configLabels()
        configButtons()
    }
    ///Configura aparencia das Labels
    func configLabels() {
        nameLabel.font = UIFont(name: "Helvetica", size: 14)
        nameLabel.numberOfLines = 3
        nameLabel.textColor = UIColor(hex: 0x43464C)
        priceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        priceLabel.textColor = UIColor(hex: 0xED6F2D)
        producerLabel.font = UIFont(name: "Helvetica", size: 10)
        producerLabel.textColor = .gray
        installmentLabel.font = UIFont(name: "Helvetica", size: 10)
        installmentLabel.textColor = .gray
    }
    
    func configButtons() {
        buyButtom.backgroundColor = UIColor(hex: 0xED6F2D)
        buyButtom.titleLabel?.textColor = .white
        buyButtom.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        buyButtom.layer.masksToBounds = false
        buyButtom.layer.cornerRadius = 6
        likeButton.setImage(UIImage(named: "coracao"), for: .normal)
        cartButton.setImage(UIImage(named: "carrinho"), for: .normal)
    }
    
    //Faz o setup das imagens. Sendo uma dinamica vinda da URL e a outra é a imagem da estrela das avaliações
    func imageSetup(url: URL?) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }
    //Configura o fundo da célula, incluindo a curvatura das pontas
    func setupBackGround() {
        self.backgroundColor = .white
        shadowDecorate(view: self)
    }
    ///Faz a configuração da View, incluindo as labels como subviews e escondendo ou não as labels de preço antigo e disconto com base nos valores.
    ///Se o valor com disconto e valor cheio forem iguais, não tem desconto e assim esses campos devem ser removidos.
    func setupView() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(producerLabel)
        self.contentView.addSubview(installmentLabel)
        self.contentView.addSubview(buyButtom)
        self.contentView.addSubview(likeButton)
        self.contentView.addSubview(cartButton)
    }
    //Configura as constraints
    func setupConstrents() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        producerLabel.translatesAutoresizingMaskIntoConstraints = false
        installmentLabel.translatesAutoresizingMaskIntoConstraints = false
        buyButtom.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        constraints.append(contentsOf: setupConstraintImageView())
        constraints.append(contentsOf: setupContraintProducerLabel())
        constraints.append(contentsOf: setupConstraintNameLabel())
        constraints.append(contentsOf: setupConstraintPriceLabel())
        constraints.append(contentsOf: setupConstraintinstallmentLabel())
        constraints.append(contentsOf: setupConstraintBuyButtom())
        constraints.append(contentsOf: setupConstraintCartButtom())
        constraints.append(contentsOf: setupConstraintLikeButtom())
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupConstraintImageView() -> [NSLayoutConstraint] {
        return [imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
                imageView.rightAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: -8),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5,constant: -20)
        ]
        
    }
    
    func setupContraintProducerLabel() -> [NSLayoutConstraint] {
        return [producerLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6),
                producerLabel.heightAnchor.constraint(equalToConstant: 15),
                producerLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8)]
    }
    func setupConstraintNameLabel() -> [NSLayoutConstraint] {
        return [nameLabel.topAnchor.constraint(equalTo: producerLabel.bottomAnchor),
         nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)]
    }
    
    func setupConstraintPriceLabel() -> [NSLayoutConstraint] {
        return [priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 8),
                priceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
                priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)]
    }
    
    func setupConstraintinstallmentLabel() -> [NSLayoutConstraint]  {
        return [installmentLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
                installmentLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
                installmentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ]
    }
    
    func setupConstraintBuyButtom() -> [NSLayoutConstraint]  {
        return [buyButtom.topAnchor.constraint(equalTo: installmentLabel.bottomAnchor, constant: 15),
                buyButtom.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
                buyButtom.heightAnchor.constraint(equalToConstant: 24)
        ]
    }
    
    func setupConstraintCartButtom() -> [NSLayoutConstraint]  {
        return [cartButton.centerYAnchor.constraint(equalTo: buyButtom.centerYAnchor),
                cartButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 4),
                cartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
                cartButton.heightAnchor.constraint(equalToConstant: 28),
                cartButton.widthAnchor.constraint(equalTo: cartButton.heightAnchor, multiplier: 1)
        ]
    }
    
    func setupConstraintLikeButtom() -> [NSLayoutConstraint]  {
        return [likeButton.centerYAnchor.constraint(equalTo: buyButtom.centerYAnchor),
                likeButton.leftAnchor.constraint(equalTo: buyButtom.rightAnchor, constant: 8),
                likeButton.heightAnchor.constraint(equalToConstant: 16),
                likeButton.widthAnchor.constraint(equalTo: cartButton.heightAnchor, multiplier: 1, constant: -6)
        ]
    }
    
    override func layoutSubviews() {
        shadowDecorate(view: imageView)
    }
    
    func shadowDecorate(view: UIView) {
        let radius: CGFloat = 10
        //corner
        view.layer.cornerRadius = radius
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.clear.cgColor
        //shadow
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
        }
}

extension ProductCollectionCell: CellProtocol {
    ///só pra conformar com o protocolo, pois ele facilita receber o identifier para registro na collectionView.
}
