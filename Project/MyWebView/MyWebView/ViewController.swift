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
        loadWebPage("http://muangs.kr")
    }
    
    func loadWebPage(_ url: String) {
        if let url = canOpen(urlString: url) {
            let myRequest = URLRequest(url: url)
            myWebView.navigationDelegate = self
            myWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
            myWebView.load(myRequest)
        } else {
            print("URL 이 유효하지 않습니다")
        }
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
    
    func canOpen(urlString: String?) -> URL? {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url) == true ? url : nil
            }
        }
        return nil
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

/**
 참고 - https://sujinnaljin.medium.com/swift-wknavigationdelegate-%EB%A9%94%EC%84%9C%EB%93%9C-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-4ba7d97063aa
 */
extension ViewController: WKNavigationDelegate {
    // 네비게이션 액션이 다운로드 되었을 경우 호출 (decisionHandler 가 .download 로 설정됨을 의미하는 듯)
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        print("navigationAction > \(navigationAction), didBecome > \(download)")
    }
    
    // 네비게이션 응답이 다운로드 되었을 경우 호출
    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
        print("navigationResponse > \(navigationResponse), didBecome > \(download)")
    }
    
    // 네비게이션이 시작되기전, 임시 허가를 받은 상태에 호출
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation > \(navigation.description)")
    }
    
    // 컨텐츠를 수신하기 시작했을 때 호출 (콘텐츠 사이즈를 구할 수 있음)
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit > \(navigation.description)")
        print(myWebView.scrollView.contentSize)
    }
    
    // 웹 페이지 로딩이 완전히 끝났을 경우 호출
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish > \(navigation.description)")
        print(myWebView.scrollView.contentSize)
    }
    
    // 초기 네비게이션 프로세스 중 오류 발생 시 호출
    // MARK: 탐색 중 오류가 아닌, URL 이 잘못되었거나, 네트워크 연결이 해제되었을 때 등 웹페이지 자체를 불러오지 못한 경우
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation > \(navigation.debugDescription), withError > \(error.localizedDescription)")
    }
    
    // 네비게이션 중 오류가 발생하면 호출 (didCommit 이후)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail > \(navigation.description), error > \(error.localizedDescription)")
    }
    
    // 웹 프로세스가 종료되었을 때 호출
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
}

