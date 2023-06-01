//
//  ListCaller.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import Foundation
import Alamofire

class ListCaller: CallerProtocol {
    var delegate: CallResponseDelegate?
    required init(delegate: CallResponseDelegate?) {
        self.delegate = delegate
    }
    ///Faz a chamada da API fazendo um Get passando os parametros
    ///app: int
    ///limite: int
    ///pagina: int
    ///Recebendo uma lista de produtos
    func callList(page: Int) {
        var paramiters: [String: Any] = ["app" : 1,
                                         "limite" : 10,
                                         "pagina" : page]
        
        AF.request("https://servicespub.prod.api.aws.grupokabum.com.br/home/v1/home/produto", method: .get, parameters: paramiters).responseJSON { response in
            do {
                let decoder = JSONDecoder()
                if let value = response.data {
                    let myResponse = try decoder.decode(ProductListModel.self, from: value)
                    print(myResponse)
                    self.delegate?.success(response: myResponse)
                } else {
                    self.delegate?.fail(errorMessage: response.error?.localizedDescription ?? "Um erro aconteceu")
                }
            }
            catch {
                self.delegate?.fail(errorMessage: error.localizedDescription)
            }
        }
    }
    
}
