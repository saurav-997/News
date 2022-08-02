//
//  WebViewController.swift
//  News
//
//  Created by Saurav Sharma on 01/08/22.
//

import Foundation
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webVCActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navigationBackButton: UIBarButtonItem!
    var myURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webVCActivityIndicator.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let myURL = myURL else {
            print("Invalid not found")
            return
        }
        webVCActivityIndicator.isHidden = true
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    @IBAction func navigationBackButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
   
}
