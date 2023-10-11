//
//  ViewController.swift
//  MyWebView
//
//  Created by 구태호 on 2021/11/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var etUrlView: UITextField!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage("http://muangs.com")
    }
    
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
        myWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    // 로딩 여부 옵저빙
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if myWebView.isLoading {
                myActivityIndicator.startAnimating()
                myActivityIndicator.isHidden = false
            } else {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.isHidden = true
            }
        }
    }

    // 입력된 URL로 이동
    @IBAction func btForward(_ sender: UIButton) {
        let myUrl = checkUrl(etUrlView.text!)
        etUrlView.text = ""
        loadWebPage(myUrl)
    }
    
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        // 변수의 앞의 문자열 일치 비교
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    // 첫 번째 사이트로 이동
    @IBAction func btnSiteOne(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    
    // 두 번째 사이트로 이동
    @IBAction func btnStieTwo(_ sender: UIButton) {
        loadWebPage("http://blog.2sam.net")
    }
    
    // 웹 뷰에 특정 HTML 코드 전달
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href = \"http://2sam.net\">sam</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    // 웹 뷰에 HTML 파일을 전달
    @IBAction func btnSendHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    // 정지
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    // 새로고침
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    // 뒤로가기
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    
    // 다음으로
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
}

