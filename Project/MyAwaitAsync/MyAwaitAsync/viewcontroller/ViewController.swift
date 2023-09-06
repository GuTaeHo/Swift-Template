//
//  ViewController.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import UIKit
import Combine


class ViewController: UIViewController {
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var btRequest: UIButton!
    
    let versionViewModel = VersionViewModel()
    var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        /// `Async/Await 테스트`
        Task {
            let (version, message) = await versionViewModel.confirmWithUrlSession(url: "http://test.check.blossom.bumblebeecrew.com/")
            
            print("\(version), \(message)")
        }
        
        bindingViews()
        initAction()
        // testCode()
        // jsonTypeMismatchTest()
    }
    
    func bindingViews() {
        versionViewModel.$response.sink(receiveValue: { [weak self] response in
            // FIXME: 초기화 시 한번 호출됨...
            /// `MainActor`로 선언된 컨텍스트(UIView 나 UIViewController 같은 UIKit 속성들..) 내에서, Swift Concurrency 를 사용하면 시스템이 적절하게 MainThread 에 디스패치된다
            /// = 현재 스레드가 백그라운드 스레드인지 메인스레드인지 신경 쓸 필요없이 업데이트
            print(Thread.isMainThread)
            Task {
                self?.labelCollection[0].text = response.result?.iosCurrentVersion
                self?.labelCollection[1].text = response.result?.iosMinVersion
                self?.labelCollection[2].text = response.result?.noticeTitle
                self?.labelCollection[3].text = response.result?.noticeContent
                self?.labelCollection[4].text = response.result?.noticeUrl
                self?.labelCollection[5].text = response.result?.apiServerAccessUrl
                self?.labelCollection[6].text = response.result?.socketServerAccessUrl
            }
        }).store(in: &cancelBag)
    }
    
    func initAction() {
        btRequest.addTarget(self, action: #selector(requestVersion), for: .touchDown)
    }
    
    @objc func requestVersion() {
        versionViewModel.requestVersion()
    }
    
    func testCode() {
        // let jsonData = Data(json.utf8)
        // log json data in pretty format
        // jsonData.printPrettyJson()
        
        var version = Version(iosMinVersion: "0.5.0", iosCurrentVersion: "0.5.0", isAccessible: true, isNoticeShow: false, noticeTitle: "서버 정기 점검 중 입니다.", noticeContent: "매월 마지막주 월요일 04:00 ~ 04:10 에는 자동 시스템 정기 점검이 진행됩니다.", noticeUrl: "", noticeColor: "#0088FF", apiServerAccessUrl: "http://test.api.blossom.bumblebeecrew.com", socketServerAccessUrl: "http://test.socket.blossom.bumblebeecrew.com", appStoreUrl: "https://apps.apple.com/kr/app/%EC%9A%B0%ED%83%80%EB%B6%81%EC%8A%A4/id1497270630")
        var response = Response(_code: 0, message: "성공", result: version)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let jsonData = try! jsonEncoder.encode(response)
        let jsonString = String(data: jsonData, encoding: .utf8)
        print(jsonString!)
        
    }
    
    func jsonTypeMismatchTest() {
        let jsonString = """
         {
           "message" : "성공",
           "result" : {
             "apiServerAccessUrl" : "http://test.api.blossom.bumblebeecrew.com",
             "socketServerAccessUrl" : "http://test.socket.blossom.bumblebeecrew.com",
             "iosMinVersion" : "0.5.0",
             "isNoticeShow" : false,
             "noticeTitle" : "서버 정기 점검 중 입니다.",
             "noticeContent" : "매월 마지막주 월요일 04:00 ~ 04:10 에는 자동 시스템 정기 점검이 진행됩니다.",
             "noticeUrl" : "",
             "noticeColor" : "#0088FF",
             "appStoreUrl" : "https://apps.apple.com/kr/app/%EC%9A%B0%ED%83%80%EB%B6%81%EC%8A%A4/id1497270630",
             "iosCurrentVersion" : "0.5.0",
             "isAccessible" : true
           },
           "code" : "0"
         }
        """
        
        print(jsonString)
        
        let jsonData = jsonString.data(using: .utf8)!
        let response = try? JSONDecoder().decode(Response<Version>.self, from: jsonData)
        print(response)
    }
}

