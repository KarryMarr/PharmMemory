//
//  BarcodeScannerViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 24.06.2025.
//

import AVFoundation
import Combine

final class BarcodeScannerViewModel: NSObject, ObservableObject {
    enum ScannerState {
        case idle
        case scanning
        case scanned(String)
        case error(Error)
    }
    
    @Published var state: ScannerState = .idle
    @Published var medicine: Medicine?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var captureSession: AVCaptureSession?
    private let sessionQueue = DispatchQueue(label: "scanner.session.queue")
    
    // MARK: - Public Methods
    
    func startScanning() {
        state = .scanning
        setupCaptureSession()
    }
    
    func stopScanning() {
        sessionQueue.async { [weak self] in
            self?.captureSession?.stopRunning()
        }
    }
    
    func resetScanner() {
        state = .idle
        medicine = nil
        errorMessage = nil
    }
    
    func fetchMedicineArticle(for barcode: String) {
        isLoading = true
        errorMessage = nil
        
        // TODO: добавить сетевой запрос
    }
    
    // MARK: - Private Methods
    
    private func setupCaptureSession() {
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            
            self.captureSession = AVCaptureSession()
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
                  let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
                  self.captureSession?.canAddInput(videoInput) == true else {
                self.handleError("Не удалось настроить камеру для сканирования")
                return
            }
            
            self.captureSession?.addInput(videoInput)
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if self.captureSession?.canAddOutput(metadataOutput) == true {
                self.captureSession?.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            } else {
                self.handleError("Сканирование штрих-кодов не поддерживается")
                return
            }
            
            self.captureSession?.startRunning()
        }
    }
    
    private func handleError(_ message: String) {
        DispatchQueue.main.async {
            let error = NSError(
                domain: "ScannerError",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: message]
            )
            self.state = .error(error)
            self.errorMessage = message
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension BarcodeScannerViewModel: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                       didOutput metadataObjects: [AVMetadataObject],
                       from connection: AVCaptureConnection) {
        stopScanning()
        
        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let barcode = readableObject.stringValue else {
            handleError("Не удалось распознать штрих-код")
            return
        }
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        fetchMedicineArticle(for: barcode)
    }
}
