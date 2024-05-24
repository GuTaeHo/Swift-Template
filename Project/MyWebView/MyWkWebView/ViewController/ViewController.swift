//
//  ViewController.swift
//  MyWKWebView
//
//  Created by 구태호 on 2021/11/24.
//

import UIKit
import WebKit
import Then
import SnapKit

class ViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var proxyView: UIView!
    lazy var webView: WKWebView? = nil
    
    let responseName = "response"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        loadWebPage("http://muangs.kr")
    }
    
    func initViews() {
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        contentController.add(WebViewLeakAvoider(delegate: self), name: responseName)
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView!.navigationDelegate = self
        webView!.uiDelegate = self
        webView!.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        
        view.addSubview(webView!)
        webView!.snp.makeConstraints {
            $0.edges.equalTo(proxyView)
        }
        
        searchBar.delegate = self
    }
    
    func loadWebPage(_ url: String) {
        if canOpen(urlString: url) {
            searchBar.text = url
            let myRequest = URLRequest(url: url.toURL!)
            webView?.load(myRequest)
        } else {
            print("URL 이 유효하지 않습니다")
        }
    }
    
    // 로딩 여부 옵저빙
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
//            if webView?.isLoading == true {
//                myActivityIndicator.startAnimating()
//                myActivityIndicator.isHidden = false
//            } else {
//                myActivityIndicator.stopAnimating()
//                myActivityIndicator.isHidden = true
//            }
        }
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
    
    func canOpen(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url) == true ? true : false
            }
        }
        return false
    }
    
    // 첫 번째 사이트로 이동
    @IBAction func btnSiteOne(_ sender: UIButton) {
        loadWebPage("http://naver.com")
    }
    
    // 두 번째 사이트로 이동
    @IBAction func btnStieTwo(_ sender: UIButton) {
        loadWebPage("http://muangs.kr")
    }
    
    // 세 번째 사이트로 이동 > 웹 뷰에 HTML 코드 그림
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href = \"http://muangs.kr\">muang</a>으로 이동</p>"
        webView?.loadHTMLString(htmlString, baseURL: nil)
    }
    
    // 네 번째 사이트로 이동 > 웹 뷰에 HTML 파일 전달
    @IBAction func btnSendHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        webView?.load(myRequest)
    }
    
    // 정지
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        webView?.stopLoading()
    }
    
    // 새로고침
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        webView?.reload()
    }
    
    // 뒤로가기
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        webView?.goBack()
    }
    
    // 다음으로
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        webView?.goForward()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let myUrl = checkUrl(searchBar.text!)
        searchBar.resignFirstResponder()
        loadWebPage(myUrl)
    }
}

extension ViewController: WKUIDelegate {
    
}

/**
 참고 - https://sujinnaljin.medium.com/swift-wknavigationdelegate-%EB%A9%94%EC%84%9C%EB%93%9C-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-4ba7d97063aa
 */
extension ViewController: WKNavigationDelegate {
    // 네비게이션 액션이 다운로드 되었을 경우 호출 (decisionHandler 가 .download 로 설정됨을 의미하는 듯)
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        print("navigationAction -> \(navigationAction), didBecome > \(download)")
    }
    
    // 네비게이션 응답이 다운로드 되었을 경우 호출
    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
        print("navigationResponse -> \(navigationResponse), didBecome > \(download)")
    }
    
    // 1. 네비게이션 전 원하는 설정 및 허용여부를 결정한다.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        //        지정된 action 정보를 기반으로, 새 콘텐츠로 이동할 수 있는 권한을 요청합니다.
        //        이 메서드를 통해 navigation request 를 허용하거나 거부할 수 있습니다.
        //
        //        웹뷰는 인터렉션 발생 후 내용을 로드하기 전에 이 메서드 먼저 호출하며,
        //        구현부에서는 항상 아래와 같은 decisionHandler 블록을 실행합니다.
        
        //        decisionHandler(.allow)
        //        decisionHandler(.cancel)
        //        decisionHandler(.download)
        let preferences = WKWebpagePreferences()
        preferences.preferredContentMode = .mobile
        preferences.allowsContentJavaScript = true
        decisionHandler(.allow, preferences)
    }
    
    // 2. 네비게이션이 시작되기전 호출된다.
    // ex) 인디케이터를 표시한다.
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation -> \(navigation.debugDescription)")
    }
    
    // 3. 네비게이션이 끝난 후, 콘텐츠 로딩을 허용할지 결정한다.
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //        navigation request 에 대한 응답을 받고 난 후, 새 콘텐츠로 이동할 수 있는 권한을 요청합니다.
        decisionHandler(.allow)
    }
    
    // 4. 웹 뷰가 컨텐츠를 수신하기 시작했을 때 호출
    // ex) 웹 뷰의 사이즈가 결정된다.
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit -> \(navigation.debugDescription)")
        print(webView.scrollView.contentSize)
    }
    
    // 5. 웹 페이지 로딩이 완전히 끝났을 경우 호출된다.
    // ex) 인디케이터를 제거한다.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish 호출 및 콘텐츠 사이즈 -> \(webView.scrollView.contentSize)")
        /// `didFinish 가 호출`되었다고 하더라도 실제 콘텐츠 사이즈가 지정된 것은 아닌듯 함.
        /// 0.1초... 후 웹 콘텐츠 사이즈를 측정하면 정확한 값이 측정되지만, 완벽한 방법은 아님.
        /// 자바 스크립트의 DOM 구조 내부를 검색하는 `document` 와 콘텐츠의 전체높이를 가진 `document.documentElement.scrollHeight` 키워드를
        /// `evaluateJavaScript(_:)`를 이용해 자바스크립트 코드를 평가하고 결과를 받을 수 있음
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("didFinish 호출 및 asyncAfter() 호출 콘텐츠 사이즈 -> \(webView.scrollView.contentSize)")
        }
        
        Task {
            var contentWidth: CGFloat = 0
            var contentHeight: CGFloat = 0
            let widthResult = await webContentWidth(webView)
            switch widthResult {
            case .success(let width):
                contentWidth = width
                break
            case .failure(_):
                break
            }
            
            let heightResult = await webContentHeight(webView)
            switch heightResult {
            case .success(let height):
                contentHeight = height
                break
            case .failure(_):
                break
            }
            
            print("실제 웹 콘텐츠 사이즈 -> \(CGSize(width: contentWidth, height: contentHeight))")
        }
    }
    
    // 6. 웹 프로세스가 종료되었을 때 호출
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
    
    // 초기 네비게이션 프로세스 중 오류 발생 시 호출
    // MARK: 탐색 중 오류가 아닌, URL 이 잘못되었거나, 네트워크 연결이 해제되었을 때 등 웹페이지 자체를 불러오지 못한 경우
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation > \(navigation.debugDescription), withError > \(error.localizedDescription)")
    }
    
    // 웹 페이지를 불러오는데 실패한 경우 호출된다. (didCommit 이후)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail > \(navigation.description), error > \(error.localizedDescription)")
    }
}

extension ViewController {
    /// 웹 뷰 콘텐츠 높이를 반환합니다.
    /// - Important: 사이즈가 0일 경우 nil 을 반환합니다.
    func webContentHeight(_ webView: WKWebView) async -> Result<CGFloat, Error> {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                webView.evaluateJavaScript("document.documentElement.scrollHeight") { (height, error) in
                    print("평가된 웹 뷰 콘텐츠 높이 -> \(height ?? 0)")
                    if let height = height as? CGFloat {
                        continuation.resume(returning: .success(height))
                    } else {
                        continuation.resume(returning: .failure(error!))
                    }
                }
            }
        }
    }
    
    /// 웹 뷰 콘텐츠 너비를 반환합니다.
    /// - Important: 사이즈가 0일 경우 nil 을 반환합니다.
    func webContentWidth(_ webView: WKWebView) async -> Result<CGFloat, Error> {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                webView.evaluateJavaScript("document.documentElement.scrollWidth") { (width, error) in
                    print("평가된 웹 뷰 콘텐츠 너비 -> \(width ?? 0)")
                    if let width = width as? CGFloat {
                        continuation.resume(returning: .success(width))
                    } else {
                        continuation.resume(returning: .failure(error!))
                    }
                }
            }
        }
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == responseName {
            let alert = UIAlertController(title: "자바스크립트 브리지", message: "\(message.body)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in })
            present(alert, animated: true)
        }
    }
}

