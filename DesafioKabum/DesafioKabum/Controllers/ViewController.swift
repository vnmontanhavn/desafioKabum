//
//  ViewController.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import UIKit

class ViewController: UIViewController {
    var caller: CallerProtocol?
    static var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        caller = ListCaller(delegate: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.caller?.callList(page: ViewController.page)
    }

}

extension ViewController: CallResponseDelegate {
    func success<T>(response: T) {
        //
    }
    
    func fail(errorMessage: String) {
        //
    }
    
    
}
