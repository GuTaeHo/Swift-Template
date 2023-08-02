//
//  TagsViewController.swift
//  MyTagsCollectionView
//
//  Created by 구태호 on 2023/08/01.
//

import UIKit


class TagsViewController: UIViewController {
    @IBOutlet weak var tagListView: UIView!
    @IBOutlet weak var tagListViewHeight: NSLayoutConstraint!
    
    var tagButtonArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTagView()
    }
    
    private func initTagView() {
        // 1. 태그 버튼 타이틀을 생성합니다.
        let tagStringArray = ["Our Faith", "1116", "Hopeful Frontier!", "Dopamine", "Anemone", "Garakuta Doll Play"]
        // 2. 타이틀 수 만큼 버튼을 생성하여 저장합니다.
        tagButtonArray = tagStringArray.map { createButton(with: $0) }
        // 3. 버튼 리스트를 돌면서 액션 함수를 지정합니다.
        tagButtonArray.forEach {
            $0.addTarget(self, action: #selector(touchTagButton), for: .touchUpInside)
        }
        
        // 4. 태그리스트 뷰에 (사이즈가 동일한) 태그 뷰를 붙입니다.
        let frame = CGRect(x: 0, y: 0, width: tagListView.frame.width, height: tagListView.frame.height)
        let tagView = UIView(frame: frame)
        // 5. 태그리스트 뷰 내부의 각 태그의 위치를 지정합니다.
        attachTagButtons(at: tagView, tagButtonArray)
        
        tagListView.addSubview(tagView)
        tagListViewHeight.constant = tagView.frame.height
    }
    
    // 태그 버튼을 생성합니다.
    private func createButton(with title: String) -> UIButton {
        let font = UIFont.systemFont(ofSize: 12)
        let fontAttributes: [NSAttributedString.Key: Any] = [.font: font]
        let fontSize = title.size(withAttributes: fontAttributes)

        let tag = UIButton(type: .custom)
        tag.setTitle(title, for: .normal)
        tag.titleLabel?.font = font
        tag.setTitleColor(.gray, for: .normal)
        tag.layer.borderColor = UIColor.gray.cgColor
        tag.layer.borderWidth = 1
        tag.layer.cornerRadius = 14
        tag.frame = CGRect(x: 0.0, y: 0.0, width: fontSize.width + 30.0, height: fontSize.height + 13.0)
        // 버튼 콘텐츠의 패딩(안쪽여백)을 지정합니다.
        tag.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 6.5, leading: 15, bottom: 6.5, trailing: 15)
        return tag
    }
    
    /// 태그뷰에 태그버튼들 붙이기
    private func attachTagButtons(at tagListView: UIView, _ tagButtons: [UIButton]) {
        var lineCount: CGFloat = 1
        let BETWEEN_TAGS_MARGIN: CGFloat = 5
        let BOTTOM_MARGIN_TAG_BEETWEEN_TAG_LIST_VIEW: CGFloat = 8

        var positionX: CGFloat = 0
        var positionY: CGFloat = 0

        /* 버튼 개수만큼 반복합니다. */
        for (index, tagButton) in tagButtons.enumerated() {
            // 태그 버튼의 위치 로직은 다음과 같습니다.
            // 1. 태그 버튼의 시작 좌표를 (0,0) 으로 잡습니다.
            /// `너비와 높이는 콘텐츠 사이즈에 맞게 표시`
            tagButton.frame = CGRect(x: positionX, y: positionY, width: tagButton.frame.width, height: tagButton.frame.height)
            // 2. 태그 버튼을 리스트 뷰에 추가합니다.
            tagListView.addSubview(tagButton)

            if index < tagButtons.count - 1 {
                // 3. 다음 태그버튼의 X 좌표를 갱신합니다
                /// `X 좌표 = 태그 버튼 너비 + 태그 사이 간격`
                positionX += tagButton.frame.width + BETWEEN_TAGS_MARGIN

                // 4. 현재 줄에 공간이 부족해 다음 태그버튼이 붙을 수 없으면 다음 줄로 내립니다.
                /// `(버튼 시작 X 좌표 + 다음 태그 버튼의 너비) > 태그 리스트(tagListView)의 너비`
                if positionX + tagButtons[index + 1].frame.width > tagListView.frame.width {
                    positionX = 0
                    positionY += tagButton.frame.height + BOTTOM_MARGIN_TAG_BEETWEEN_TAG_LIST_VIEW
                    lineCount += 1
                }
            }
        }

        /* 태그뷰 높이 계산 */
        // 1. 첫 번째 태그 버튼의 높이를 획득합니다.
        let height = tagListView.subviews.first?.frame.height ?? 0
        // 2. 버튼과 태그 리스트 뷰의 하단 마진을 구합니다. (1 줄 -> 0, 2 줄 -> 8, 3줄 -> 16...)
        let margins: CGFloat = (lineCount - 1) * BOTTOM_MARGIN_TAG_BEETWEEN_TAG_LIST_VIEW
        // 3. 태그 리스트의 프레임을 업데이트 합니다.
        // (너비 -> 본래 너비, 높이 -> (버튼 행 수 + 단일 버튼 높이) + 마진)
        tagListView.frame = CGRect(x: 0, y: 0, width: tagListView.frame.width, height: (lineCount * height) + margins)
    }
    
    /// 태그버튼 클릭시
    @objc func touchTagButton(sender: UIButton) {
        // 태그 선택 여부 반전
        sender.isSelected = !sender.isSelected
        sender.setTitleColor(sender.isSelected ? .white : .gray, for: .normal)
        sender.layer.borderColor = sender.isSelected ? UIColor.clear.cgColor : UIColor.gray.cgColor
        sender.backgroundColor = sender.isSelected ? .gray : .white

        // 태그 하나만 선택할 수 있도록 함
        tagButtonArray.filter { $0 != sender }.forEach {
            $0.isSelected = false
            $0.setTitleColor(.gray, for: .normal)
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.backgroundColor = .white
        }
    }
}
