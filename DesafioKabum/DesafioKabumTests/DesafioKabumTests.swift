//
//  DesafioKabumTests.swift
//  DesafioKabumTests
//
//  Created by Vinicius Soares Lima on 30/05/23.
//

import XCTest
@testable import DesafioKabum

class MockSuccess: CallerProtocol {
    var delegate: DesafioKabum.CallResponseDelegate?
    
    required init(delegate: DesafioKabum.CallResponseDelegate?) {
        self.delegate = delegate
    }
    
    func callList(page: Int) {
        print("Meu Mock:")
        let path = Bundle.main.path(forResource: "Produto", ofType: "json", inDirectory: "")
        print(path)
        let decoder = JSONDecoder()
        guard let dataPath = path, let data = try? Data(contentsOf: URL(fileURLWithPath: dataPath)), let myResponse = try? decoder.decode(ProductListModel.self, from: data) else {
            return
        }
        print("respostaMockada")
        print(myResponse)
        delegate?.success(response: myResponse)
        
    }
    
}

final class DesafioKabumTests: XCTestCase {
    var mock: MockSuccess?
    var controller: ViewController?
    override func setUpWithError() throws {
        controller = ViewController()
        mock = MockSuccess(delegate: controller)
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
    }
}
