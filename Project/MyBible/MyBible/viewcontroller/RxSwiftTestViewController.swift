//
//  RxSwiftTestViewController.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/25.
//

import RxSwift
import RxCocoa


class RxSwiftTestViewController: UIViewController {
    @IBOutlet var btTest: CommonButton!
    @IBOutlet var lbTest: UILabel!
    
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btTest.rx.tap.subscribe(onNext: { [weak self] in
            self?.lbTest.text = "Observable의 항목(item)이 방출"
        }, onError: { _ in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
    }
}
