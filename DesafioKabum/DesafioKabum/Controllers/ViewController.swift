//
//  ViewController.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: ProductsFlowLayout()
        )
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private var model: ProductListModel?
    var caller: CallerProtocol?
    var products: [ProductModel] = []
    var stop = false
    
    static var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xFAFAFB)
        setupCollectionView()
        setupConstraints()
        caller = ListCaller(delegate: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
        self.caller?.callList(page: ViewController.page)
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell().getIdentifier())
        collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
        
    }
    
    func setupConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
}

extension ViewController: CallResponseDelegate {
    func success<T>(response: T) {
        indicator.stopAnimating()
        ViewController.page += 1
        print(ViewController.page)
        if let response = response as? ProductListModel {
            if response.products?.count == 0 {
                stop = true
            }
            self.products.append(contentsOf: response.products ?? [])
            collectionView.reloadData()
        }
    }
    
    func fail(errorMessage: String) {
        indicator.stopAnimating()
        print(errorMessage)
    }
    
    
}
