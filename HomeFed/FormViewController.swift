//
//  FormViewController.swift
//  HomeFed
//
//  Created by Kothapalli on 7/11/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import Foundation
import PDFKit
import MessageUI


class FormViewController: UIViewController, PDFViewDelegate, MFMailComposeViewControllerDelegate {
    
    var formName: String?
    
    @IBOutlet weak var pdfViewHolder: UIView!
    
    let mailComposer = MFMailComposeViewController()
    let pdfView = PDFView()
    override func viewDidLoad() {
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        pdfView.delegate = self
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfViewHolder.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: pdfViewHolder.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: pdfViewHolder.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: pdfViewHolder.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: pdfViewHolder.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        guard let path = Bundle.main.url(forResource: formName, withExtension: "pdf")
            else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        
        pdfView.displayMode = .singlePage
        
        mailComposer.mailComposeDelegate = self
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBAction func goToPreviousPage(_ sender: Any) {
        pdfView.goToPreviousPage(sender)
    }
    
    @IBAction func goToNextPage(_ sender: Any) {
        pdfView.goToNextPage(sender)
    }
    
    @IBAction func submitPDF(_ sender: Any) {

        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
        let data = pdfView.document?.dataRepresentation() else {return}
        let formNameUrl = formName! + ".pdf"
        let fileURL = url.appendingPathComponent(formNameUrl)
        do {
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
        
        if( MFMailComposeViewController.canSendMail() )
        {
            print("Can send email.")
            
            
            //Set to recipients
            mailComposer.setToRecipients(["shakotha@gmail.com"])
            
            //Set the subject
            mailComposer.setSubject("email with document pdf")
            
            //set mail body
            mailComposer.setMessageBody("This is what they sound like.", isHTML: true)

                
                if let fileData = NSData(contentsOfFile: fileURL.path)
                {
                    print("File data loaded.")
                    mailComposer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "All_about_tax.pdf")
                    
                }
            
            
            //this will compose and present mail to user
            self.present(mailComposer, animated: true, completion: nil)
        }
        else
        {
            print("email is not supported")
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
