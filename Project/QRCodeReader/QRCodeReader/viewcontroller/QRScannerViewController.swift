//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by 구태호 on 2023/09/16.
//

import UIKit
import AVFoundation


class QRScannerViewController: UIViewController {
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView = .init().then {
        $0.layer.borderColor = UIColor.green.cgColor
        $0.layer.borderWidth = 5
    }
    
    var messageLabel: UILabel = .init().then {
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 24)
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
            view.bringSubviewToFront(qrCodeFrameView)
            
            // 캡쳐 시작
            captureSession.startRunning()
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
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    /// QR 코드가 인식될 경우 호출
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        // 캡쳐 데이터 획득
        let metadataObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        
        if metadataObject.type == AVMetadataObject.ObjectType.qr {
            // 메타데이터가 QR code 형태와 일치하면, 라벨에 정보 지정 및 프레임을 qr 코드 크기에 맞게 조정
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
            qrCodeFrameView.frame = barCodeObject!.bounds
            
            if metadataObject.stringValue != nil {
                messageLabel.text = metadataObject.stringValue
            }
        }
    }
}
