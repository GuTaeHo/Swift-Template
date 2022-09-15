//
//  ViewController.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkPresenter = NetworkPresenter()
        networkPresenter.getPostWithNumber(postNumber: 1) { response, error in
            if let error = error {
                print("\(error)")
            }
            
            guard
                // ResponsePosts 타입 반환
                let response = response
            else {
                print(response)
                return
            }

            print(response)
            print(response.title ?? "")
        }
    }
}

