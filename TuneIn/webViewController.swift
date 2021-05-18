//
//  webViewController.swift
//  tableview
//
//  Created by Lindsay Penkrat on 5/9/21.
//

import UIKit
import WebKit

class webViewController: UIViewController, WKNavigationDelegate  {

    @IBOutlet var webView: WKWebView!
    var backButton: UIBarButtonItem?
    var forwardButton: UIBarButtonItem?
    var reloadButton: UIBarButtonItem?
    
    override func viewDidLoad()
    {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()

        let request = URLRequest(url: URL(string: "https://www.ticketmaster.com/discover/concerts/boston")!)

        webView?.load(request)
   
        //setup buttons
//        self.backButton?.isEnabled = self.webView.canGoBack
//            self.forwardButton?.isEnabled = self.webView.canGoForward
//            self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
//            self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)

        self.navigationController?.setToolbarHidden(false, animated: true)
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left")!.withTintColor(.blue, renderingMode: .alwaysTemplate),
            style: .plain,
            target: self.webView,
            action: #selector(WKWebView.goBack))
        let forwardButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.right")!.withTintColor(.blue, renderingMode: .alwaysTemplate),
            style: .plain,
            target: self.webView,
            action: #selector(WKWebView.goForward))
        let reloadButton = UIBarButtonItem(
                   image: UIImage(systemName: "arrow.counterclockwise")!.withTintColor(.blue, renderingMode: .alwaysTemplate),
                   style: .plain,
                   target: self.webView,
                   action: #selector(WKWebView.reload))

        self.toolbarItems = [backButton, forwardButton,
                             UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),reloadButton]
        self.backButton = backButton
        self.forwardButton = forwardButton
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//        if let _ = object as? WKWebView {
//            if keyPath == #keyPath(WKWebView.canGoBack) {
//                self.backButton?.isEnabled = self.webView.canGoBack
//            } else if keyPath == #keyPath(WKWebView.canGoForward) {
//                self.forwardButton?.isEnabled = self.webView.canGoForward
//            }
//        }
//    }
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
//    {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView,_didStartProvisionalNavigation: WKNavigation)
//    {
//        print(#function)
//    }
//    func  webView(_ webView: WKWebView,didCommit _didCommit: WKNavigation)
//    {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView,didFinish _didFinish: WKNavigation)
//    {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView, _didFail withError: WKNavigation)
//    {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView,_didFailProvisionalNavigation withError: WKNavigation)
//    {
//        print(#function)
//    }
    

}
   
    
    
    
    


