//
//  CellsProtocols.swift
//  
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit

//protocolo unificado para as celulas, é usado pela tableview e pelo builder
protocol CellProtocol {
    func getIdentifier() -> String
}

//implementaçoes que são defaut e ultilitarias são fetas aqui
extension CellProtocol {
    func getIdentifier() -> String {
        return String(describing: type(of: self))
    }
}

