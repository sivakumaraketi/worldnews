//
//  WebviewViewController.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/19/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webview: WKWebView!
   
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
   @objc func ShareClicked()
   {
    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    activityVC.popoverPresentationController?.sourceView = self.view
    self.present(activityVC, animated: true, completion: nil)
}
    
    var rechability:Reachability?
    
   var url:String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activity.isHidden = true
        self.rechability = Reachability.init()
        
        if ((self.rechability!.connection) != .none){
        
        var RightBarButton : UIBarButtonItem = UIBarButtonItem(title: "Share", style: UIBarButtonItemStyle.plain, target: self, action: Selector("ShareClicked"))
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = RightBarButton
            loadaddress()
        
        
        }else {
          
           print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
           alert.show()
            
            
        }
    }
    
    func loadaddress(){
        if url != nil{
            webview.load(URLRequest(url: URL(string: url!)!))
        }else{
            let alert = UIAlertView(title: "No Url", message: "Make sure url value not empty.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
    }
    
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
    }
    /*private func webViewDidStartLoad(_ webView : WKWebView!){
        self.activity.startAnimating()
        
        NSLog("web view is loaded")
    }
    
    private func webViewDidFinishLoad(_ webView : WKWebView!){
        self.activity.stopAnimating()
        NSLog("web view is done loading")
    }
*/


}

