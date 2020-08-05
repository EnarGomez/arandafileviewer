//
//  DocumentViewController.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 26/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class DocumentViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDocumentName: UILabel!
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblError: UILabel!
    
    typealias CompletionHandler = ((_ canShowFile: Bool, _ viewController: DocumentViewController?) -> Void)
    
    var webView: WKWebView!
    var imageView: UIImageView!
    var fileURL: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.configureView()
    }
    
    private func configureView(){
        Utils.setRoundedCornesButton(self.viewContainer, color: Utils.hexStringToUIColor(hex: "#f8f8f8"), size: 5)
        Utils.setRoundedCornesButton(self.container, color: .clear, size: 5)
        viewContainer.backgroundColor = Utils.hexStringToUIColor(hex: "#f8f8f8")
    }
    
    func configureWebview(){
        webView = WKWebView()
        webView.frame = self.container.frame
        webView.frame.origin.x = 0
        webView.frame.origin.y = 0
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.container.addSubview(webView)
        self.container.bringSubviewToFront(webView)
    }
    
    func configureError(){
        //view.backgroundColor = .white
        self.container.backgroundColor = Utils.hexStringToUIColor(hex: "#8b8b8b")
        self.imgError.isHidden = false
        self.imgError.image =  UIImage(named: "iconImageError", in: Utils.getBundle(), compatibleWith: nil)
        self.lblError.isHidden = false
        self.lblError.textColor = Utils.hexStringToUIColor(hex: "#a7a7a7")
        self.lblError.text = Utils.stringNamed("Preview_not_available")
    }
    
    
    
    
    func loadRequest(urlToLoad: String){
        let request:URLRequest = URLRequest(url: URL(string: urlToLoad)!)
        self.webView.load(request)
    }
    
    func loadDocument(fileName: String){
        self.lblDocumentName.text = fileName
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            if let dirPath = paths[0] as String? {
                let fileManager = FileManager.default
                self.fileURL = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                if fileManager.fileExists(atPath: self.fileURL.path){
                    self.configureWebview()
                    self.webView.loadFileURL(self.fileURL, allowingReadAccessTo: self.fileURL.deletingLastPathComponent())
                }else{
                    self.configureError()
                }
            }
            else{
                self.configureError()
            }
        }else{
            self.configureError()
        }
    }
    
    func loadDocumentInPath(path: String){
       let fileManager = FileManager.default
       self.fileURL = URL(fileURLWithPath: path)
       self.lblDocumentName.text = self.fileURL.lastPathComponent
       if fileManager.fileExists(atPath: self.fileURL.path){
           self.configureWebview()
           self.webView.loadFileURL(self.fileURL, allowingReadAccessTo: self.fileURL.deletingLastPathComponent())
       }else{
           self.configureError()
       }
               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Inicia")
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("WebView content loaded1.")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finish")
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.configureError()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.configureError()
    }
        

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url != fileURL {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if navigationResponse.canShowMIMEType {
            decisionHandler(.allow)
            return
        }
        
        decisionHandler(.cancel)
    }
}
