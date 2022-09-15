//
//  ViewController.swift
//  MyBundle
//
//  Created by 구태호 on 2022/06/20.
//

import UIKit

// Bundle 이란 App 내에 포함된 리소스를 보유한 디렉토리
class ViewController: UIViewController {
    @IBOutlet weak var btChange: UIButton!
    @IBOutlet var ivBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btChange.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
        
        // 번들 경로 출력
        // print(Bundle.main.bundlePath)
        // print(Bundle.main.bundleURL)
        // print(Bundle.main.path(forResource: "Cocobean", ofType: "plist")!)
        
        // MARK: cocobean.plist 파일 경로 획득 (추후 Deplecated 됨)
        guard
            let cocobeanPlistsPathWithPath = Bundle.main.path(forResource: "Cocobean", ofType: "plist")
        else {
            print("Cocobean.plist can't found")
            return
        }
        
        // 딕셔너리 형태로 파일 변환
        if let cocobeanString = NSDictionary(contentsOfFile: cocobeanPlistsPathWithPath)?["cocobeanString"] as? String {
            // 키를 통해 값 획득 및 출력
            print(cocobeanString)
        }
        
        if let cocobeanNumber = NSDictionary(contentsOfFile: cocobeanPlistsPathWithPath)?["cocobeanNumber"] as? NSNumber {
            print(cocobeanNumber)
        }
        
        // Bundle.main.infoDictionary 는 기본적으로 생성된 Info.plist 파일을 봄
        if let cocobeanDic = Bundle.main.infoDictionary {
            print(cocobeanDic["cocobeanBoolean"] as! Bool)
        }
        
        // MARK: cocobean.plist 파일 경로 획득
        guard
            let cocobeanPlistPathWithUrl = Bundle.main.url(forResource: "Cocobean", withExtension: "plist")
        else {
            print("Cocobean.plist can't found")
            return
        }
        
        var config = [String:Any]()
        
        do {
            let infoPlistData = try Data(contentsOf: cocobeanPlistPathWithUrl)
            
            if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, format: nil) as? [String:Any] {
                config = dict
            }
        } catch {
            print(error)
        }
        
        print(config["cocobeanNumber"] as! Int)
    }
    
    @objc
    private func onClickButton() {
        ivBackground.image = UIImage(named: "Minecraft")
    }
}

