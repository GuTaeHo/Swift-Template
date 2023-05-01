//
//  RxSwiftDataReceivedTestViewController.swift
//  MyBible
//
//  Created by 구태호 on 2023/05/01.
//

import RxSwift
import RxCocoa


class RxSwiftDataReceivedTestViewController: UIViewController {
    var accountViewModel: AccountViewModel?
    
    @IBOutlet var lbName: CommonLabel!
    @IBOutlet var lbAge: CommonLabel!
    
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 모델 데이터 > 라벨 적용
        accountViewModel?.name.asDriver()
            .drive(lbName.rx.text)
            .disposed(by: disposeBag)
        
        accountViewModel?.age.asDriver()
            .drive(lbAge.rx.text)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("RxSwiftDataReceivedTestViewController DEINIT")
    }
}
