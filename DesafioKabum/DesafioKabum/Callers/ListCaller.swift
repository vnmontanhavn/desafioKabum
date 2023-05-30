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
    
    func callList(page: Int) {
        var paramiters: [String: Any] = ["app" : 1,
                                         "limite" : 10,
                                         "pagina" : page]
        
        AF.request("https://servicespub.prod.api.aws.grupokabum.com.br/home/v1/home/produto", method: .get, parameters: paramiters).responseJSON { response in
            print(response)
        }
    }
    
}
