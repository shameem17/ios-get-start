//
//  WebViewController.swift
//  AllinOne
//
//  Created by flash on 10/11/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView : WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.style = .large
        //        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        let loadURL = "https://www.cricbuzz.com"
        let url = URL(string: loadURL)!
        webView.load(URLRequest(url: url))
        activityIndicator.stopAnimating()
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    
}

extension WebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
}
