//
//  CellsProtocols.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 12/05/23.
//

import Foundation
import UIKit

//protocolo unificado para as celulas, é usado pela tableview e pelo builder
protocol CellProtocol {
    func height() -> CGFloat
    func getCell() -> UITableViewCell
    func getIdentifier() -> String
}

//implementaçoes que são defaut e ultilitarias são fetas aqui
extension CellProtocol {
    func getCell() -> UITableViewCell {
        if let cell = self as? UITableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func getIdentifier() -> String {
        return String(describing: type(of: self))
    }
}

