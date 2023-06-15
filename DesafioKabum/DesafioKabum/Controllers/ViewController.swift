//
//  ViewController.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: ProductsFlowLayout()
        )
    lazy var errorView = ErrorView()
    var caller: CallerProtocol?
    var products: [ProductModel] = []
    var stop = false
    static var page = 1
    var activityDelegate: ActivityProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0x285EAB)
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex: 0x285EAB)
        setupCollectionView()
        setupConstraints()
        addNavigationIcon()
        caller = ListCaller(delegate: self)
        errorView.setup(viewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoading()
        self.caller?.callList(page: ViewController.page)
    }
    //método para colocar o icone na navigation e configura aparencia dela
    func addNavigationIcon() {
        let icon = UIImageView(image: UIImage(named: "kabum"))
        let appearance = UINavigationBarAppearance()
        guard let naviBar = self.navigationController?.navigationBar else {
            return
        }
        appearance.configureWithTransparentBackground()
        naviBar.standardAppearance = appearance
        icon.contentMode = .scaleAspectFit
        naviBar.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: naviBar.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: naviBar.centerXAnchor),
            icon.heightAnchor.constraint(equalTo: naviBar.heightAnchor, multiplier: 1)
            ])
        
    }
    
    ///Faz as configurações da collectionview e a coloca na view
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionCell.self,
                                forCellWithReuseIdentifier: ProductCollectionCell().getIdentifier())
        collectionView.register(IndicatorCollectionFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: IndicatorCollectionFooterView.identifier)
        self.collectionView.backgroundColor = UIColor(hex: 0xFAFAFB)
        self.view.addSubview(collectionView)
        
    }
    //Configura as constraints da collectionview
    func setupConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant:60),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
}

extension ViewController: CallResponseDelegate {
    ///Metodo chamado pela classe de chamada quando o retorno for um sucesso
    func success<T>(response: T) {
        stopLoading()
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
    ///Metodo chamado pela classe de chamadas quando o retorno for um erro
    func fail(errorMessage: String) {
        stopLoading()
        print(errorMessage)
        errorView.showError(message: errorMessage)
    }
}
///Metodos para facilitar o uso do Activity Indicator
extension ViewController: ActivityProtocol {
    func startLoading() {
        activityDelegate?.startLoading()
    }
    
    func stopLoading() {
        activityDelegate?.stopLoading()
    }
    
    func isLoading() -> Bool {
        return activityDelegate?.isLoading() ?? false
    }
}
