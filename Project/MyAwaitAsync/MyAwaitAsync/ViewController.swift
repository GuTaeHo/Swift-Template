//
//  ViewController.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import UIKit

class ViewController: UIViewController {
    
    let versionViewModel = VersionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            guard let response = try await versionViewModel.confirmWithUrlSession(url: "http://test.check.blossom.bumblebeecrew.com/") else {
                print("조회 실패...")
                return
            }
            
            guard let version = response.result else {
                print("\(response.message ?? "서버 메시지 없음...")")
                return
            }
            
        }
    }


}

