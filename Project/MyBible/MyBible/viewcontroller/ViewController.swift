//
//  ViewController.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var baseTextFieldView: CommonTextFieldView!
    @IBOutlet var underlineLabelView: CommonLabelView!
    @IBOutlet var btRxSwiftRxCocoaTest: CommonButton!
    @IBOutlet var btShortMessage: CommonButton!
    @IBOutlet var btMassiveMessage: CommonButton!
    @IBOutlet var lbDeviceIPAddress: UILabel!
    @IBOutlet var lbCellularIPAddress: UILabel!
    @IBOutlet var lbWifiIPAddress: UILabel!
    @IBOutlet var lbNetworkStatus: UILabel!
    @IBOutlet var btUITabBarTest: CommonButton!
    @IBOutlet var btNext: CommonButton!
    
    private var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: safeAreaLayoutGuild 추가 정리하기
        /*
         let safeAreaGuide = view.safeAreaLayoutGuide
         tintButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 18).isActive = true
         tintButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 18).isActive = true
         tintButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -18).isActive = true
         */
        addKeyboardObserver(showKeyboardSelector: #selector(showKeyboard), hideKeyboardSelector: #selector(hideKeyboard))
        initAction()
        initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let status = ReachabilityStatus()

        switch status.currentReachabilityStatus {
        case .reachableViaWiFi:
            lbWifiIPAddress.text = status.getAddress(for: .wifi)
            lbCellularIPAddress.text = "연결 X"
        case .reachableViaWWAN:
            lbCellularIPAddress.text = status.getAddress(for: .cellular)
            lbWifiIPAddress.text = "연결 X"
        default:
            break
        }
        
        lbDeviceIPAddress.text = UIDevice().ipAddress()
        /*
        NetworkMonitor().startMonitoring { networkStatus in
            self.lbNetworkStatus.text = networkStatus.rawValue
        }
         */
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    func initAction() {
        /* 라벨 클릭 */
        underlineLabelView.labelClickClosure = { [self] _ in
            underlineLabelView.underline = true
            showToast(message: "지정된 URL: \(underlineLabelView.url ?? "지정된 URL 없음!")", bottomPadding: keyboardHeight, bottomView: btNext)
        }
        
        btRxSwiftRxCocoaTest.addAction() { [weak self] in
            if let viewController: RxSwiftDataSendTestViewController = self?.viewController(storyboardType: .main) {
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        btShortMessage.addAction(isIndicate: true) { [weak self] in
            self?.showToast(message: "NVidia Tegra X1 chop inside Switch", bottomPadding: self?.keyboardHeight, bottomView: self?.btNext)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.btShortMessage.hideIndicator()
            }
        }
        
        btMassiveMessage.addAction(isIndicate: true) { [weak self] in
            self?.showToast(message: "When the view is visible onscreen, this guide reflects the portion of the view that is not covered by navigation bars, tab bars, toolbars, and other ancestor views. (In tvOS, the safe area reflects the area not covered the screen's bezel.) If the view is not currently installed in a view hierarchy, or is not yet visible onscreen, the layout guide edges are equal to the edges of the view.", bottomPadding: self?.keyboardHeight, bottomView: self?.btNext)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.btMassiveMessage.hideIndicator()
            }
        }
        
        btUITabBarTest.addAction { [weak self] in
            guard let viewController: ToolBarViewController = self?.viewController(storyboardType: .main) else { return }
            
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self?.present(navigationController, animated: true)
        }
        
        btNext.addAction { [weak self] in
            if let viewController: TableViewController = self?.viewController(storyboardType: .main) {
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func initLayout() {
        btNext.changeNextButtonLayout(viewController: self)
    }
    
    @objc func showKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
    }
    
    @objc func hideKeyboard() {
        keyboardHeight = 0
    }
}

