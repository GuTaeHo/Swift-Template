//
//  ViewController.swift
//  MyAVSpeechSynthesizer
//
//  Created by 구태호 on 2023/01/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    // 로컬 변수로 선언되면 할당 즉시 해제됨 주의!
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    
    @IBAction func onClickSpeech(_ sender: Any) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}

