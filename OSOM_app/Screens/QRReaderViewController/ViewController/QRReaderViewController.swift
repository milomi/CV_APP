//
//  QRReaderViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import UIKit
import AVFoundation

class QRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    fileprivate var mainView: QRReaderView?
    fileprivate var viewModel: QRReaderViewModelImpl?
    
    var videoCaptureDevice = AVCaptureDevice.default(for: .video)
    var device = AVCaptureDevice.default(for: .video)
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureSession = AVCaptureSession()
    var code: String?
    
    var scannedCode = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        addLabelForDisplayingCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    private func setupCamera() {
        
        guard let videoCaptureDevice = videoCaptureDevice, let input = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            return
        }
        
        if self.captureSession.canAddInput(input) {
            self.captureSession.addInput(input)
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let videoPreviewLayer = self.previewLayer {
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = self.view.bounds
            view.layer.addSublayer(videoPreviewLayer)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if self.captureSession.canAddOutput(metadataOutput) {
            self.captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.aztec]
            
        } else {
            print("Could not add metadata output")
        }
    }
    
    private func addLabelForDisplayingCode() {
        view.addSubview(scannedCode)
        scannedCode.translatesAutoresizingMaskIntoConstraints = false
        scannedCode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
        scannedCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        scannedCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        scannedCode.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scannedCode.font = UIFont.preferredFont(forTextStyle: .title2)
        scannedCode.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        scannedCode.textAlignment = .center
        scannedCode.textColor = UIColor.white
        scannedCode.text = "Scanning...."
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // This is the delegate'smethod that is called when a code is readed
        
        print(metadataObjects)
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            let code = readableObject.stringValue
            scannedCode.text = code
        }
    }
}
