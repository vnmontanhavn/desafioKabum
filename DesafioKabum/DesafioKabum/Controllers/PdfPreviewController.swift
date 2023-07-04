//
//  PdfPreviewController.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 04/07/23.
//

import Foundation
import UIKit
import PDFKit

class PdfPreviewController: UIViewController {
    var pdfView = PDFView()
    override func viewDidLoad() {
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoScales = true
        view.addSubview(pdfView)
        let handler = PdfHandler()
        handler.pdfPreview(pdfData: handler.generatePDF(), view: &pdfView)
        setupConstraints()
    }
    func setupConstraints(){
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: view.topAnchor,constant:60),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pdfView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pdfView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
}
