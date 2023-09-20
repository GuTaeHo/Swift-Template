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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
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
         */
        
        Task {
            // await requestAdvertisement()
            let params = CommonShowAdInfoRequest(serviceCode: .daeguro, showCode: .mainPopUp)
            let (response, error) = await AdNetworkClientForIgnoreSSL().requestAd(url: "/showAdInfo", params: params)
            
            dump("@@@ \(error)")
            dump("@@@ \(response)")
        }
    }
    
    private func requestAdvertisement() async {
        let request = CommonShowAdInfoRequest(serviceCode: .daeguro, showCode: .mainPopUp)
        // let (response, errorMsg) = await AdNetworkPresenter().showAdInfo(request)
        let (response, errorMsg) = await NetworkPresenter().showAdInfo(request)
       
        guard let response = response else {
            print(errorMsg)
            return
        }
        
        print(response)
    }
}

