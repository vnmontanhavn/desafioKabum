//
//  ProductModel.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import Foundation

struct ProductModel: Decodable {
    var code: Int?
    var image: String?
    var name: String?
    var freeDelivery: Bool?
    var price: String?
    var discountPrice: String?
    var reviewQtd: Int?
    var reviewScore: Int?
    var percentDiscount: String?
    private enum CodingKeys: String, CodingKey {
        case code = "codigo"
        case image = "img"
        case name = "nome"
        case freeDelivery = "tem_frete_gratis"
        case price = "preco_formatado"
        case discountPrice = "preco_desconto_formatado"
        case reviewQtd = "avaliacao_numero"
        case reviewScore = "avaliacao_nota"
        case percentDiscount = "porcentagem_desconto"
    }
}
