//
//  ViewController.swift
//  MyAVFoundation
//
//  Created by 구태호 on 2022/10/29.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var videoViewContainer: UIView!
    
    var player: AVPlayer?
    var layer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initializeVideoPlayerWithVideo()
        
        MultimediaUtil.playVideo(view: videoViewContainer, videoString: "SampleVideo.mp4")
    }
    
    /*
    func initializeVideoPlayerWithVideo() {
        
        // get the path string for the video from assets
        let videoString:String? = Bundle.main.path(forResource: "SampleVideo", ofType: "mp4")
        guard let unwrappedVideoPath = videoString else {
            return print("비디오를 찾을 수 없음")
        }
        
        // convert the path string to a url
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        // initialize the video player with the url
        player = AVPlayer(url: videoUrl)
        // 플레이어 동작(비디오 끝) 감지
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        // create a video layer for the player
        layer = AVPlayerLayer(player: player)
        // 비디오를 UIView 크기에 맞게 변경
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // 컨테이너에 비디오 추가
        videoViewContainer.layer.addSublayer(layer)
        view.layoutIfNeeded()
        // 사이즈 일치시킴
        layer.frame = videoViewContainer.bounds
        player?.play()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        print("Video Finished")
        // 영상 초기화 및 다시 재생
        player?.seek(to: CMTime.zero)
        print("Video PlayTime Init")
        player?.play()
        print("Video Played")
    }
     */
}

