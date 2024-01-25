//
//  ViewController.swift
//  MyFileManager
//
//  Created by 구태호 on 1/25/24.
//

import UIKit

/**
 파일 매니저를 사용해 디렉토리 및 파일 생성, 삭제, 변경 예제
 
 - Info.plist 에 `Supports opening documents in place = YES` 와 `Application supports iTunes file sharing = YES` 를
 설정해주어야 `파일 앱`에 표시된다.
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fileManager = FileManager.default
        print("currentDirectoryPath: \(fileManager.currentDirectoryPath)")
        print("urls: \(fileManager.urls(for: .documentDirectory, in: .userDomainMask))")
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        print("lastPathComponent: \(fileManager.urls(for: .documentDirectory, in: .userDomainMask))")
        let directoryUrl = documentsUrl.appendingPathComponent("FileManager 왜 안보임?")
        let fileUrl = documentsUrl.appendingPathComponent("Cocobean 의 파일.txt")
        
        let str = "Hello, Cocobean!"
        try? str.write(to: fileUrl, atomically: false, encoding: .utf8)
//        do {
//            try fileManager.createDirectory(at: directoryUrl, withIntermediateDirectories: false)
//        } catch let error {
//            print("디렉토리 생성 실패: \(error.localizedDescription)")
//        }
    }
}

