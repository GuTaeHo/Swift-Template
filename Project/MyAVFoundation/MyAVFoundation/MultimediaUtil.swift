//
//  MultimediaUtil.swift
//  MyAVFoundation
//
//  Created by 구태호 on 2022/10/30.
//

import Foundation
import UIKit
import AVFoundation

class MultimediaUtil {
    /// 해당 뷰에 로컬 비디오를 재생
    /// - parameter view: 비디오를 재생할 UIView
    /// - parameter videoUrl: 비디오 명과 형식 (ex: Sample.mp4)
    public static func playVideo(view: UIView, videoString: String, replayButton: UIView) {
        let fileString = videoString.components(separatedBy: ".")
        // get the path string for the video from assets
        let videoString:String? = Bundle.main.path(forResource: "\(fileString[0])", ofType: "\(fileString[1])")
        guard let unwrappedVideoPath = videoString else {
            return print("비디오를 찾을 수 없음")
        }
        
        // convert the path string to a url
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        // initialize the video player with the url
        let player = AVPlayer(url: videoUrl)
        // 플레이어 동작(비디오 끝) 감지
        // NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(noti:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        // create a video layer for the player
        let layer = AVPlayerLayer(player: player)
        // 비디오 비율변경
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // UIView에 비디오 추가
        view.layer.addSublayer(layer)
        view.layoutIfNeeded()
        // 사이즈 일치
        layer.frame = view.bounds
        player.play()
        replayButton.isHidden = true
    }
    
    @objc func playerDidFinishPlaying(noti: EmbededPlayerNotification) {
        // 영상 초기화 및 다시 재생
        noti.player?.seek(to: CMTime.zero)
        noti.player?.play()
    }
    
    /*
    // AVPlayer 가 포함된 NSNotification 클래스
    class EmbededPlayerNotification: NSNotification {
        var player: AVPlayer?
    }
     */
}
