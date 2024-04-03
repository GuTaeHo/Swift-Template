//
//  ViewController.swift
//  MyUITextView
//
//  Created by 구태호 on 4/2/24.
//

import UIKit

class ViewController: UIViewController {
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("current start range: \(range.location)")
        print("current range length: \(range.length)")
        print("replacementText: \(text)")
        print("limit range: \(text.count + range.length)")
        if textView.text.count + text.count < 1000 {
            print("가능")
            return true
        } else {
            print("불가")
            return false
        }
    }
}

