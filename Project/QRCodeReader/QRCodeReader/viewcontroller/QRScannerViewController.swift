//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by 구태호 on 2023/09/16.
//

import UIKit
import AVFoundation


class QRScannerViewController: UIViewController {
    /// 디바이스 입, 출력 데이터 가공
    var captureSession = AVCaptureSession()
    /// 카메라 미리보기 레이어
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    /// qr코드 가이드
    var qrCodeFrameView = UIView()
    /// qr코드 브라켓
    var qrCodeBraket = CAShapeLayer()
    
    var blurView: UIVisualEffectView = .init().then {
        let blurEffect = UIBlurEffect(style: .dark)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.effect = blurEffect
        $0.layer.masksToBounds = true
    }
    
    var messageLabel: UILabel = .init().then {
        $0.textColor = .white
        $0.text = "인식된 QR 이 없습니다."
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getListOfCamerasAsString())
        
        // 후면 카메라 획득
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("장치를 확인하지 못했습니다.")
            return
        }
        
        do {
            // 캡쳐한 영상정보를 획득하여 관리하는 객체 생성
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // AVCaptureSession 은 입력받은 미디어 데이터를 화면에 출력하는 형태로 조정함
            // 출력은 AVCaptureMetadataOutputObjectsDelegate 에서 가로채서 원하는 대로 변경가능
            captureSession.addInput(input)
            
            // AVCaptureMetadataOutput 객체를 초기화하고, 캡처 세션으로 출력 장치를 지정함
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // 위임자를 지정하고 콜백형태를 메인 큐(Apple 문서에서 대기열은 직렬로 지정해야한다고 함)로 지정
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            // 출력 데이터의 타입을 지정해줌, qr 코드를 읽는게 목적이므로 타입은 qr
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // 후면 카메라로 캡쳐한 데이터를 화면에 표시하기 위해 AVCaptureVideoPreviewLayer 호출
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            view.addSubview(qrCodeFrameView)
            view.addSubview(blurView)
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            blurView.contentView.addSubview(messageLabel)
            blurView.layoutIfNeeded()
            blurView.layer.cornerRadius = blurView.frame.height / 2
            messageLabel.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 12).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 12).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -12).isActive = true
            messageLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -36).isActive = true
            view.bringSubviewToFront(qrCodeFrameView)
            qrCodeFrameView.layer.addSublayer(qrCodeBraket)
            
            // 캡쳐 시작
            DispatchQueue.global().async {
                self.captureSession.startRunning()
            }
        } catch {
            messageLabel.text = "\(error.localizedDescription)"
            view.addSubview(messageLabel)
            
            
            // TODO: 에러 발생, 이전 화면으로 전환
            return
        }
    }
    
    /// Returns all cameras on the device.
    public func getListOfCameras() -> [AVCaptureDevice] {
        
        let session = AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                .builtInWideAngleCamera,
                .builtInTelephotoCamera
            ],
            mediaType: .video,
            position: .unspecified)
        
        return session.devices
    }
    
    /// Converts giving AVCaptureDevice list to the String
    public func convertDeviceListToString(_ devices: [AVCaptureDevice]) -> [String] {
        var names: [String] = []
        
        for device in devices {
            names.append(device.localizedName)
        }
        
        return names
    }
    
    public func getListOfCamerasAsString() -> [String] {
        let devices = getListOfCameras()
        return convertDeviceListToString(devices)
    }
    
    private func makeCameraLayer(rect: CGRect) -> CAShapeLayer {
        // 카메라 뷰 사이즈에 맞게 레이어 초기화
        let guideLayer = CAShapeLayer()
        guideLayer.frame = rect
        guideLayer.lineWidth = 10
        
        // 패스 생성
        let path = UIBezierPath()
        
        // 브라켓 세 점의 위치
        var pathA: CGPoint = .zero
        var pathB: CGPoint = .zero
        var pathC: CGPoint = .zero
        
        /* 좌측 상단 브라켓 */
        pathA.x = guideLayer.bounds.minX
        pathA.y = guideLayer.bounds.minY + 30
        pathB.x = guideLayer.bounds.minX
        pathB.y = guideLayer.bounds.minY
        pathC.x = guideLayer.bounds.minX + 30
        pathC.y = guideLayer.bounds.minY
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        /* 우측 상단 브라켓 */
        pathA.x = guideLayer.bounds.maxX - 30
        pathA.y = guideLayer.bounds.minY
        pathB.x = guideLayer.bounds.maxX
        pathB.y = guideLayer.bounds.minY
        pathC.x = guideLayer.bounds.maxX
        pathC.y = guideLayer.bounds.minY + 30
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        /* 우측 하단 브라켓 */
        pathA.x = guideLayer.bounds.maxX
        pathA.y = guideLayer.bounds.maxY - 30
        pathB.x = guideLayer.bounds.maxX
        pathB.y = guideLayer.bounds.maxY
        pathC.x = guideLayer.bounds.maxX - 30
        pathC.y = guideLayer.bounds.maxY
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        /* 좌측 하단 브라켓 */
        pathA.x = guideLayer.bounds.minX + 30
        pathA.y = guideLayer.bounds.maxY
        pathB.x = guideLayer.bounds.minX
        pathB.y = guideLayer.bounds.maxY
        pathC.x = guideLayer.bounds.minX
        pathC.y = guideLayer.bounds.maxY - 30
        
        path.move(to: pathA)
        path.addLine(to: pathB)
        path.addLine(to: pathC)
        
        guideLayer.path = path.cgPath
        guideLayer.lineCap = .round
        guideLayer.lineJoin = .round
        return guideLayer
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    /// QR 코드가 인식될 경우 호출
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // 인식된 객체가 없을 경우
        if metadataObjects.count == 0 {
            qrCodeFrameView.layer.borderColor = UIColor.systemGray5.cgColor
            qrCodeFrameView.frame = CGRect(origin: .zero, size: .init(width: 200, height: 200))
            qrCodeFrameView.center = view.center
            qrCodeBraket.frame = qrCodeFrameView.frame
            qrCodeBraket.strokeColor = UIColor.systemGray4.cgColor
            qrCodeBraket = makeCameraLayer(rect: qrCodeFrameView.frame)
            qrCodeFrameView.layer.addSublayer(qrCodeBraket)
            messageLabel.text = "인식된 QR 코드가 없습니다."
            return
        }
        
        // 캡쳐 데이터 획득
        let metadataObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        
        if metadataObject.type == AVMetadataObject.ObjectType.qr {
            // 메타데이터가 QR code 형태와 일치하면, 라벨에 정보 지정 및 프레임을 qr 코드 크기에 맞게 조정
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
            qrCodeFrameView.frame = barCodeObject!.bounds
            qrCodeBraket.frame = barCodeObject!.bounds
            qrCodeBraket.strokeColor = UIColor.systemPink.cgColor
            qrCodeBraket = makeCameraLayer(rect: barCodeObject!.bounds)
            qrCodeFrameView.layer.addSublayer(qrCodeBraket)
            
            // 메타데이터 정보를 텍스트로 표시
            if metadataObject.stringValue != nil {
                messageLabel.text = metadataObject.stringValue
            }
        }
    }
}
