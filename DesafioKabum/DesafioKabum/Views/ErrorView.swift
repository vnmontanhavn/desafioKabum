//
//  ErrorView.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 31/05/23.
//

import Foundation
import UIKit

class ErrorView: UIView {
    var textLabel = UILabel()
    private var showConstraint: NSLayoutConstraint?
    private var hideConstraint: NSLayoutConstraint?
    private var viewController: UIViewController?
    
    ///Faz a configuração da view. Ele foi feito para ser generico e poder ser usado em qualquer viewController.
    func setup(viewController: UIViewController) {
        viewController.view.addSubview(self)
        self.viewController = viewController
        self.addSubview(textLabel)
        textLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        textLabel.numberOfLines = 3
        textLabel.textColor = .white
        setupConstraints()
        let touch = UITapGestureRecognizer(target: self, action: #selector(hideError))
        self.addGestureRecognizer(touch)
        self.backgroundColor = .red
        
    }
    ///Configura Constraints
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = self.superview, let view = self.viewController else {
            return
        }
        self.showConstraint = self.topAnchor.constraint(equalTo: view.view.topAnchor)
        self.hideConstraint = self.bottomAnchor.constraint(equalTo: superView.topAnchor)
        NSLayoutConstraint.activate([
            self.rightAnchor.constraint(equalTo: view.view.rightAnchor),
            self.leftAnchor.constraint(equalTo: view.view.leftAnchor),
            self.heightAnchor.constraint(equalTo: textLabel.heightAnchor, multiplier: 1, constant: 46),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
            ])
        hideError()
    }
    ///Método para mostrar a view de erro
    func showError(message: String) {
        viewController?.navigationController?.setNavigationBarHidden(true, animated: true)
        self.isHidden = false
        ErrorView.animate(withDuration: 2, delay: 0.5) {
            self.textLabel.text = message
            self.hideConstraint?.isActive = false
            self.showConstraint?.isActive = true
        }
        
    }
    ///Método para esconder a view de erro
    @objc
    func hideError() {
        viewController?.navigationController?.setNavigationBarHidden(false, animated: true)
        ErrorView.animate(withDuration: 2, delay: 0.5) {
            self.hideConstraint?.isActive = true
            self.showConstraint?.isActive = false
        }completion: { _ in
            self.isHidden = true
        }
    }
    
}
