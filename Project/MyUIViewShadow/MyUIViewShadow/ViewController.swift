//
//  ViewController.swift
//  MyUIViewShadow
//
//  Created by 구태호 on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageOnShadowView: UIImageView!
    
    lazy var shadowView = {
        let shadowView = RoundedShadowView()
        shadowView.innerBackgroundColor = .orange
        shadowView.isCornerRounded = true
        shadowView.shadowColor = .darkGray
        shadowView.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowView.shadowOpacity = 1.0
        shadowView.shadowRadius = 4
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()
    
    let imageUrls = ["https://images.contentstack.io/v3/assets/blt731acb42bb3d1659/blt15d3facea57e5b7e/634613111338101198fce129/K_Sante-Base-Splash.jpg", "https://i.namu.wiki/i/TEaH-T2HpKCSQMAVlkSfVHgXXXE3yQ26sIZrx12svuCr2ZcdoF9Sq5Ezqb7cUmiSO3dJ8IVZ4pkDLtcPFI3ToQ.webp",
         "https://i.ytimg.com/vi/iYOOzf-rZGQ/maxresdefault.jpg",
         "https://static.inven.co.kr/column/2022/11/02/news/i13755462008.jpg",
         "https://images.contentstack.io/v3/assets/blt731acb42bb3d1659/blt4c8fb4538c2e872a/6348e16aad35ab2389ac9ef5/KSante_Ability_P_Thumbnai.jpg"
    ]
    
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -128),
            shadowView.widthAnchor.constraint(equalToConstant: 128),
            shadowView.heightAnchor.constraint(equalToConstant: 128),
            shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            self.count += 1
            
            let maxCapacity = imageUrls.count
            
            let imageIndex = self.count % maxCapacity
            
            self.imageOnShadowView.imageDownload(url: imageUrls[imageIndex], contentMode: .scaleAspectFill)
        })
    }
}

