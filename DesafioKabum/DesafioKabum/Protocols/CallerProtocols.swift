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
    func call()
    func callList(page: Int)
}

extension CallerProtocol {
    func call(userURL: String?) {
        //
    }
    func call() {
        //
    }
    func callList(page: Int) {
        //
    }
}
