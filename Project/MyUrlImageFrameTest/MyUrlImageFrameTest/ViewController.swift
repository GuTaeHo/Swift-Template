//
//  ViewController.swift
//  MyUrlImageFrameTest
//
//  Created by 구태호 on 2023/05/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addNewImageViewInStackView(url: "https://blog.wijman.net/content/images/size/w760h400/2021/12/debian-11-bullseye.png")
        addNewImageViewInStackView(url: "https://i.ebayimg.com/images/g/L5UAAOSwyHdhhBL6/s-l1600.jpg")
        addNewImageViewInStackView(url: "https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Raspberry_Pi_4_Model_B.jpg")
        addNewImageViewInStackView(url: "https://blog.wijman.net/content/images/size/w760h400/2021/12/debian-11-bullseye.png")
        addNewImageViewInStackView(url: "https://i.ebayimg.com/images/g/L5UAAOSwyHdhhBL6/s-l1600.jpg")
        addNewImageViewInStackView(url: "https://cdn.mos.cms.futurecdn.net/b75Q68Gb65uDNS6EpSnNN9.jpg")
        gifImageView.urlImage(url: "https://i.pinimg.com/originals/ef/0c/85/ef0c851f501afbdd512f836cef172a39.gif")
    }
    
    /// 스택 뷰에 이미지 뷰 추가
    func addNewImageViewInStackView(url: String) {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        /* urlImage 내부에서 추가 시 비동기적으로 추가되기 때문에 밖으로 빼서 처리*/
        stackView.addArrangedSubview(imageView)
        
        imageView.urlImage(url: url) { [weak self] image in
            guard let stackView = self?.stackView else { return }
            // 1. 이미지 원본 너비, 높이 획득
            let imageOriginWidth = image?.size.width ?? 0
            let imageOriginHeight = image?.size.height ?? 0
            
            // 2. 너비에 대한 높이 비율 획득
            let heightRatio = imageOriginHeight/imageOriginWidth
            
            // 3. 상위 뷰 너비에 맞게 높이 조정
            let imageViewWidth = stackView.bounds.width
            let scaledHeight = imageViewWidth * heightRatio
            
            // 4. 이미지 너비 및 높이 제약조건 조정
            imageView.snp.remakeConstraints {
                $0.width.equalTo(imageViewWidth)
                $0.height.equalTo(scaledHeight)
            }
            imageView.image = image
        }
    }
}

