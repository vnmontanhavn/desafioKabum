//
//  CallerProtocols.swift
//  DesafioGithub
//
//  Created by Vinicius Soares Lima on 15/05/23.
//

import Foundation

protocol CallResponseDelegate {
    func success<T>(response: T)
    func fail(errorMessage: String)
}

protocol CallerProtocol {
    init(delegate: CallResponseDelegate?)
    var delegate: CallResponseDelegate? {get set}
    func call(userURL: String?)
    func callList(page: Int)
}
///Implementa métodos defaut para que a implementação deles seja opcional
extension CallerProtocol {
    ///Este método foi pensado para ser usado em uma chamada de detalhes, que não foi implementada.
    func call(userURL: String?) {
        //
    }
    func callList(page: Int) {
        //
    }
}
