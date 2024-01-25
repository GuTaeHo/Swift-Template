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
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    @IBOutlet var lbDescriptor: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(LocalFileManager.shared.rootUrl?.absoluteString ?? "")
        
        let url = LocalFileManager.shared.rootUrl?.appendingPathComponent("FileManagerTest")
        let fileNames = LocalFileManager.shared.entities(at: url)?.compactMap { $0 }
        lbDescriptor.text = "저장된 파일 & 디렉토리: \(String(describing: fileNames))"
        
        let fileUrl = url?.appendingPathComponent("코코빈의 파일.txt")
        lbDescriptor.text = LocalFileManager.shared.readFile(at: fileUrl)
    }
    
    @IBAction func save(_ sender: UIButton) {
        let url = LocalFileManager.shared.rootUrl?.appendingPathComponent("FileManagerTest")
        LocalFileManager.shared.makeFile(at: url, title: "\(textField.text ?? "NoTitle")", contents: "\(textView.text ?? "")", type: .txt)
        
        let fileNames = LocalFileManager.shared.entities(at: url)?.compactMap {
            $0
        }
        lbDescriptor.text = "저장된 파일 & 디렉토리: \(String(describing: fileNames))"
    }
}

