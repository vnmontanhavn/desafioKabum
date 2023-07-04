//
//  PdfHandler.swift
//  DesafioKabum
//
//  Created by Vinicius Soares Lima on 04/07/23.
//

import Foundation
import PDFKit


class PdfHandler {
    func generatePDF() -> Data {
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = [ kCGPDFContextAuthor as String : "Montanha" ]
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let graphc = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), format: format)
        let data = graphc.pdfData { (context) in
            // 5
            context.beginPage()
            // 6
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
            ]
            let text = "I'm a PDF!"
            text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        }
        return data
    }
    
    func pdfPreview(pdfData: Data?, view: inout PDFView) {
        if let data = pdfData {
            view.document = PDFDocument(data: data)
            view.autoScales = true
        }
    }
}
