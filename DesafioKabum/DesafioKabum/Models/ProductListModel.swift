//
//  ProductList.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import Foundation

///Modelo da Lista
struct ProductListModel: Decodable {
    var products: [ProductModel]?
    var blackFriday: Int?
    private enum CodingKeys: String, CodingKey {
        case products = "produtos"
        case blackFriday = "flag_blackfriday"
    }
}
