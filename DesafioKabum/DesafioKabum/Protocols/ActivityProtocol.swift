//
//  FooterProtocol.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 31/05/23.
//

import Foundation
//Protocolo visando padronizar métodos para tratar indicadores de Atividade.
protocol ActivityProtocol {
    func startLoading()
    func stopLoading()
    func isLoading() -> Bool
}
