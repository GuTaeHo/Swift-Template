//
//  RxSwiftDataSendTestViewController.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/25.
//

import RxSwift
import RxCocoa
import RxGesture


class RxSwiftDataSendTestViewController: UIViewController {
    @IBOutlet var btTest: CommonButton!
    @IBOutlet var lbTest: UILabel!
    @IBOutlet var tfName: CommonTextFieldView!
    @IBOutlet var tfAge: CommonTextFieldView!
    
    @IBOutlet var lbName: CommonLabel!
    @IBOutlet var lbAge: CommonLabel!
    
    var disposeBag: DisposeBag = .init()
    lazy var accountViewModel: AccountViewModel = { return AccountViewModel() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btTest.rx.tap.subscribe(onNext: { [weak self] in
            self?.lbTest.text = "Observable의 항목(item)이 방출"
        }).disposed(by: disposeBag)
        
        // MARK: 텍스트 필드  > 뷰 모델 바인딩
        tfName.tfMessage.rx
            .text
            .orEmpty
            .bind(to: accountViewModel.name)
            .disposed(by: disposeBag)
        
        tfAge.tfMessage.rx
            .text
            .orEmpty
            .bind(to: accountViewModel.age)
            .disposed(by: disposeBag)
        
        tfName.deleteButtonView.rx
            .tapGesture()
            // 최초로 바인딩할 때도 한번 호출되기 때문에 when() 메소드를 통해 무시
            .when(.recognized)
            .bind(onNext: { [weak self] tapGestureRecognizer in
                self?.lbName.text = ""
            }).disposed(by: disposeBag)
        
        tfAge.deleteButtonView.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] tapGestureRecognizer in
                self?.lbAge.text = ""
            }).disposed(by: disposeBag)
        
        // MARK: return 클릭 시 호출
        tfAge.tfMessage.rx
            .controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                if let viewController: RxSwiftDataReceivedTestViewController = self?.viewController(storyboardType: .main) {
                    /* 뷰 모델 전달 */
                    viewController.accountViewModel = self?.accountViewModel
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        // MARK: 뷰 모델 변경 사항 > 라벨에 반영
        accountViewModel.name.asDriver()
            .drive(lbName.rx.text)
            .disposed(by: disposeBag)
        
        accountViewModel.age.asDriver()
            .drive(lbAge.rx.text)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("RxSwiftDataSendTestViewController DEINIT")
    }
}
