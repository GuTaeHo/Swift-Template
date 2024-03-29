//
//  ViewController.swift
//  MyCardSelectCollectionView
//
//  Created by 구태호 on 2022/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cardCollectionView: UICollectionView!
    @IBOutlet var card2CollectionView: UICollectionView!
    
    private var currentIndex: CGFloat = 0    // 현재 보여지고 있는 페이지의 인덱스
    
    private var cardCollectionViewAdapter: CardCollectionViewAdapter!
    private var cards = ["현대카드", "삼성카드", "우리카드", "신한카드", "비씨카드"]
    
    private var card2CollectionViewAdapter: CardCollectionViewAdapter!
    private var cards2 = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardCollectionViewAdapter = CardCollectionViewAdapter(collectionView: cardCollectionView)
        card2CollectionViewAdapter = CardCollectionViewAdapter(collectionView: card2CollectionView)
        
        initLayout()
    }
    
    private func initLayout() {
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        card2CollectionView.delegate = self
        card2CollectionView.dataSource = self
        
        // UICollectionViewFlowLayout()은 각 콜렉션 뷰 마다 별도로 생성해서 적용해주어야함
        // MARK: 하나의 flowLayout을 공유하면 itemCount에 관계 없이 콜렉션 뷰의 개수가 같게 보임...
        let flowLayout = UICollectionViewFlowLayout()
        // 카드 사이즈
        let cardWidth = cardCollectionView.frame.width * 0.7
        let cardHeight = cardCollectionView.frame.height
        flowLayout.itemSize = CGSize(width: cardWidth, height: cardHeight)
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.scrollDirection = .horizontal
        // 콜렉션 뷰 패딩 적용 (콜렉션 뷰 및 카드 사이즈에 맞게 패딩 적용[가운데 정렬])
        let padding = (cardCollectionView.bounds.width - cardWidth) / 2
        // 콜렉션 뷰 스크롤 가속
        cardCollectionView.decelerationRate = .fast
        cardCollectionView.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        cardCollectionView.collectionViewLayout = flowLayout
        cardCollectionViewAdapter.initItems(items: cards)
        cardCollectionView.reloadData()
        
        let flowLayout2 = UICollectionViewFlowLayout()
        // 카드 사이즈
        let cardWidth2 = card2CollectionView.frame.width * 0.7
        let cardHeight2 = card2CollectionView.frame.height
        flowLayout2.itemSize = CGSize(width: cardWidth2, height: cardHeight2)
        flowLayout2.minimumLineSpacing = 10.0
        flowLayout2.scrollDirection = .horizontal
        
        card2CollectionView.decelerationRate = .fast
        card2CollectionView.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        card2CollectionView.collectionViewLayout = flowLayout2
        card2CollectionViewAdapter.initItems(items: cards2)
        card2CollectionView.reloadData()
    }
    
    private func selectedIndexCardCollectionView() -> Int {
        // contentOffset은 콜렉션 뷰의 origin에서 현재 얼마나 떨어져 있는지를 CGPoint로 반환하는듯
        let visibleRect = CGRect(origin: self.cardCollectionView.contentOffset, size: self.cardCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        // CGPoint를 기반으로 UICollectionView의 현재 위치를 찾는듯
        if let visibleIndexPath = cardCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.item
        } else {
            // 셀좌표를 셀 스페이싱만큼 왼쪽으로 옮김
            let adjustXPosition = visibleRect.midX - 10
            let adjustPoint = CGPoint(x: adjustXPosition, y: visibleRect.midY)
            return cardCollectionView.indexPathForItem(at: adjustPoint)!.item
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case cardCollectionView:
            return cardCollectionViewAdapter.getItemCount()
            
        case card2CollectionView:
            return card2CollectionViewAdapter.getItemCount()
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case cardCollectionView:
            return cardCollectionViewAdapter.collectionView(collectionView, cellForItemAt: indexPath)
            
        case card2CollectionView:
            return card2CollectionViewAdapter.collectionView(collectionView, cellForItemAt: indexPath)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: targetContentOffset은 드래그 종료 후 목표 좌표(현재 좌표가 아님!!!)를 반환하는 듯,
    // MARK: scrollView.contentOffset은 현재 스크롤 좌표를 반환함
    // MARK: targetContentOffset.pointee를 통해 CGPoint 형태로 액세스 할 수 있음
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        switch scrollView {
        case cardCollectionView:
            // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
            let layout = cardCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            print("\(layout.itemSize.width), \(cardCollectionView.contentInset.left)")
            
            // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
            // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
            var offset = targetContentOffset.pointee
            let index = (offset.x + cardCollectionView.contentInset.left) / cellWidthIncludingSpacing
            var roundedIndex = round(index)
            
            // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
            // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
            // 스크롤로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
            print(scrollView.contentOffset.x)
            print(cardCollectionView.contentOffset.x)
            print(targetContentOffset.pointee.x)
            if cardCollectionView.contentOffset.x > targetContentOffset.pointee.x {
                roundedIndex = floor(index)
            } else if cardCollectionView.contentOffset.x < targetContentOffset.pointee.x {
                roundedIndex = ceil(index)
            } else {
                roundedIndex = round(index)
            }
            
            // 한 번에 한 카드만 전환되도록 변경
            if currentIndex > roundedIndex {
                currentIndex -= 1
                roundedIndex = currentIndex
            } else if currentIndex < roundedIndex {
                currentIndex += 1
                roundedIndex = currentIndex
            }
            
            // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset(목표 좌표)에 대입하면 됨
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - cardCollectionView.contentInset.left, y: -cardCollectionView.contentInset.top)
            targetContentOffset.pointee = offset
            break
            
        case card2CollectionView:
            // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
            let layout = card2CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            print("\(layout.itemSize.width), \(card2CollectionView.contentInset.left)")
            
            // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
            // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
            var offset = targetContentOffset.pointee
            let index = (offset.x + card2CollectionView.contentInset.left) / cellWidthIncludingSpacing
            var roundedIndex = round(index)
            
            // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
            // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
            // 스크롤로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
            print(scrollView.contentOffset.x)
            print(card2CollectionView.contentOffset.x)
            print(targetContentOffset.pointee.x)
            if card2CollectionView.contentOffset.x > targetContentOffset.pointee.x {
                roundedIndex = floor(index)
            } else if card2CollectionView.contentOffset.x < targetContentOffset.pointee.x {
                roundedIndex = ceil(index)
            } else {
                roundedIndex = round(index)
            }
            
            // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset(목표 좌표)에 대입하면 됨
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - card2CollectionView.contentInset.left, y: -card2CollectionView.contentInset.top)
            targetContentOffset.pointee = offset
            break
            
        default:
            break
        }
    }
}

