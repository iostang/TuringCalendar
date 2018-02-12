//
//  ViewController.swift
//  TuringCalendar
//
//  Created by TangChi on 2018/2/12.
//  Copyright © 2018年 TangChi. All rights reserved.
//

import UIKit
import M13PDFKit

class ViewController: UIViewController {
    
    lazy var pdfView: PDFKBasicPDFViewer = {
        let path = Bundle.main.path(forResource: "calendar", ofType: "pdf")
        let document = PDFKDocument(contentsOfFile: path!, password: nil)
        let pdfView = PDFKBasicPDFViewer(document: document)
        return pdfView!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(pdfView.view)
        pdfView.view.frame = view.bounds
        pdfView.navigationToolbar.removeFromSuperview()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pdfView.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25) {
            let today = self.getWeekByDate(date: Date())
            self.pdfView.displayPage(UInt(today))
        }
    }
    
    func getWeekByDate(date: Date) -> Int {
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
            return 0
        }
        let components = calendar.components([.weekOfYear,.weekOfMonth,.weekday,.weekdayOrdinal], from: date)
        
        return components.weekOfYear!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
