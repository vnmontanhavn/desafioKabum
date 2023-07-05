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
        title = "Minha Ficha"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTapped))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let document = pdfView.document,
           let firstPage = document.page(at: 0)
        {
            let firstPageBounds = firstPage.bounds(for: pdfView.displayBox)
            pdfView.go(to: CGRect(x: 0, y: firstPageBounds.height, width: 1.0, height: 1.0), on: firstPage)
        }
    }
    @objc
    func addTapped(){
        var filesToShare = [Any]()
        guard let documentURL = PdfHandler().generatePDF().dataToFile(fileName: "ficha.pdf") else {
            return
        }
        filesToShare.append(documentURL)
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
                
        self.present(activityViewController, animated: true, completion: nil)
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

extension Data {
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {
        
        // Make a constant from the data
        let data = self
        
        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))
            
            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)
            
        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }
        
        // Returns nil if there was an error in the do-catch -block
        return nil
        
    }
    
}
