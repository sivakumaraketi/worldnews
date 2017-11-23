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
  
    
    var url: String?
    var rechability:Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.isHidden = true
        self.rechability = Reachability.init()
        
        if ((self.rechability!.connection) != .none){
        
        var RightBarButton : UIBarButtonItem = UIBarButtonItem(title: "Share", style: UIBarButtonItemStyle.plain, target: self, action: Selector("ShareClicked"))
        
        self.navigationItem.rightBarButtonItem = RightBarButton
        
        print("getname:", url)
        loadaddress()
        
        
        }else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
    }
    
    func loadaddress(){
        
        //  let requestURL = NSURL(url)
        //  let request = NSURLRequest(URL: requestURL)
        //    webview.loadrequest(request)
        webview.load(URLRequest(url: URL(string: url!)!))
        
        
        
    }
    
    
    func webViewDidStartLoad(webview : WKWebView!){
        activity.startAnimating()
        
        NSLog("web view is loaded")
    }
    
    func webViewDidFinishLoad(webview : WKWebView!){
        self.activity.stopAnimating()
        NSLog("web view is done loading")
    }



}

