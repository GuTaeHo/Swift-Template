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
        
        
        /*
        /// `Async/Await 테스트`
        Task {
            let (version, message) = await versionViewModel.confirmWithUrlSession(url: "http://test.check.blossom.bumblebeecrew.com/")
            
            print("\(version), \(message)")
        }
         */
        
        bindingViews()
        initAction()
    }
    
    func bindingViews() {
        versionViewModel.$response.sink(receiveValue: { [weak self] response in
            // TODO: 초기화 시 한번 호출됨...
            print("\(response)")
        }).store(in: &cancelBag)
    }
    
    func initAction() {
        btRequest.addTarget(self, action: #selector(requestVersion), for: .touchDown)
    }
    
    @objc func requestVersion() {
        versionViewModel.requestVersion()
    }
}

