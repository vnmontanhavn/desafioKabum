//
//  DesafioKabumTests.swift
//  DesafioKabumTests
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import XCTest
@testable import DesafioKabum

class MockError: CallerProtocol {
    var delegate: DesafioKabum.CallResponseDelegate?
    
    required init(delegate: DesafioKabum.CallResponseDelegate?) {
        self.delegate = delegate
    }
    func callList(page: Int) {
        self.delegate?.fail(errorMessage: "Teste de Error")
    }
}

class MockSuccess: CallerProtocol {
    var delegate: DesafioKabum.CallResponseDelegate?
    
    required init(delegate: DesafioKabum.CallResponseDelegate?) {
        self.delegate = delegate
    }
    
    func callList(page: Int) {
        let path = Bundle.main.path(forResource: "Produto", ofType: "json", inDirectory: "")
        let decoder = JSONDecoder()
        guard let dataPath = path, let data = try? Data(contentsOf: URL(fileURLWithPath: dataPath)), let myResponse = try? decoder.decode(ProductListModel.self, from: data) else {
            return
        }
        delegate?.success(response: myResponse)
    }
}

final class DesafioKabumTests: XCTestCase {
    var mock: MockSuccess?
    var mockError: MockError?
    var controller: ViewController?
    override func setUpWithError() throws {
        controller = ViewController()
        mock = MockSuccess(delegate: controller)
        mockError = MockError(delegate: controller)
        controller?.caller = mock
        controller?.view.layoutIfNeeded()
    }

    override func tearDownWithError() throws {
        controller = nil
    }

    func testTitle() throws {
        controller?.viewDidLoad()
        controller?.caller = mock
        controller?.viewWillAppear(false)
        controller?.viewWillAppear(false)
        XCTAssertEqual(controller?.title, "Produtos")
    }
    
    func testCollection() throws {
        guard let controller = self.controller else {
            XCTAssertTrue(false)
            return
        }
        controller.viewDidLoad()
        controller.caller = mock
        controller.viewWillAppear(false)
        controller.viewWillAppear(false)
        XCTAssertEqual(controller.collectionView.numberOfItems(inSection: 0), 2)
        let index = IndexPath(row: 0, section: 0)
        let cell = controller.collectionView(controller.collectionView, cellForItemAt: index) as? ProductCollectionCell
        XCTAssertEqual(cell?.nameLabel.text, "Notebook Asus AMD Ryzen 5-3500U, 8GB RAM, SSD 256GB, 15,6\', Radeon Vega 8, Windows 11 Home, Cinza - M515DA-BR1213W")
    }
    
    func testError() throws {
        guard let controller = self.controller else {
            XCTAssertTrue(false)
            return
        }
        controller.viewDidLoad()
        controller.caller = mockError
        controller.viewWillAppear(false)
        controller.viewWillAppear(false)
        XCTAssertEqual(controller.errorView.textLabel.text, "Teste de Error")
    }
}
