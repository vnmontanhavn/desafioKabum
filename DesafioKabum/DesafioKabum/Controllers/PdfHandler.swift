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
            context.beginPage()
            let textFont = UIFont.boldSystemFont(ofSize: 12)
            let text = "Frenesi: Uma vez por rodada, se estiver em fúria e usar a ação agredir para fazer um ataque corpo a corpo ou com uma arma de arremesso, você pode gastar 2 PM para fazer um ataque adicional."
            var height = text.height(withConstrainedWidth: pageWidth / 2, font: textFont)
            let label = UILabel()
            if height > pageHeight - 10 {
                print("Meu macaco pos um ovo")
            }
            label.text = text
            label.font = textFont
            label.numberOfLines = 0
            var yPosition: Double = 0
            while yPosition < pageHeight {
                height = text.height(withConstrainedWidth: pageWidth / 2, font: textFont)
                if yPosition + height >= pageHeight {
                    break
                }
                label.drawText(in: CGRect(x: 0, y: yPosition, width: pageWidth / 2, height: height))
                yPosition = yPosition + height
            }
            
            let image = UIImage(named: "kabum")
            image?.draw(in: CGRect(x: pageWidth / 2, y: 20, width: 30, height: 30))
            yPosition = 50
            while yPosition < pageHeight {
                height = text.height(withConstrainedWidth: pageWidth / 2, font: textFont)
                if yPosition + height >= pageHeight {
                    break
                }
                label.drawText(in: CGRect(x: pageWidth / 2, y: yPosition, width: pageWidth / 2, height: height))
                yPosition = yPosition + height
            }
            
            context.beginPage()
            
            let border = PDFBorder()
            border.lineWidth = 10
            border.draw(in: CGRect(x: 0, y: 0, width: 200, height: 200))
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

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
