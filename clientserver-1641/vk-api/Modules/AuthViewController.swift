//
//  AuthViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeToVKAPI()
    }
    
    func authorizeToVKAPI() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        print(url)
        
        ///https://oauth.vk.com/blank.html#access_token=5c1064b909e4d2e9f8584e6879aba7dda04604d60677d2d68f9aadb04b211e41efcc13fdd84808960f328&expires_in=86400&user_id=223761261
        
        //access_token
        //5c1064b909e4d2e9f8584e6879aba7dda04604d60677d2d68f9aadb04b211e41efcc13fdd84808960f328
        //expires_in
        //86400
        //user_id
        //223761261
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0] //четный key
                let value = param[1] //нечетный value
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"], let userId = params["user_id"] else { return }
        
        print(token)
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        performSegue(withIdentifier: "showFriendsSegue", sender: nil)
        
        decisionHandler(.cancel)
    }
}
