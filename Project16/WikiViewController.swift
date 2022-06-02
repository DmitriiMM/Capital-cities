//
//  WikiViewController.swift
//  Project16
//
//  Created by Дмитрий Мартынов on 01.12.2021.
//

import UIKit
import WebKit

class WikiViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var cities = ["Париж", "Осло", "Лондон", "Рим", "Вашингтон"]
    var placeName: String!
    
    /*
     https://ru.wikipedia.org/wiki/Париж
     https://ru.wikipedia.org/wiki/Осло
     https://ru.wikipedia.org/wiki/Лондон
     https://ru.wikipedia.org/wiki/Рим
     https://ru.wikipedia.org/wiki/Вашингтон
    */
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://ru.wikipedia.org/wiki/\(placeName ?? "")") else { return }  
        
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToMap))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func backToMap() {
        _ = navigationController?.popViewController(animated: true)
        }
        
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let url = navigationAction.request.url
//
//        if let host = url!.host {
//            for website in cities {
//                if host.range(of: website) != nil {
//                    decisionHandler(.allow)
//                    return
//                }
//            }
//        }
//        decisionHandler(.cancel)
//    }
}

