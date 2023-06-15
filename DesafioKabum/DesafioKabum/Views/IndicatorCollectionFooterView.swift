//
//  IndicatorCollectionFooterView.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 31/05/23.
//

import Foundation
import UIKit

class IndicatorCollectionFooterView: UICollectionReusableView {
    static let identifier = "footer"
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        startLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension IndicatorCollectionFooterView: ActivityProtocol {
    func startLoading() {
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
    }
    
    func isLoading() -> Bool {
        return indicator.isAnimating
    }
    
    
}
