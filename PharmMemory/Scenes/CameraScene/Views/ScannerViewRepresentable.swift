//
//  ScannerViewRepresentable.swift
//  PharmMemory
//
//  Created by Karina Blinova on 24.06.2025.
//
import SwiftUI
import AVFoundation

struct ScannerViewRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: BarcodeScannerViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: viewModel.captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            layer.frame = uiView.bounds
        }
    }
}
