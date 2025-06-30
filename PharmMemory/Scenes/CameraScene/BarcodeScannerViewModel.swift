//
//  BarcodeScannerViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 24.06.2025.
//
import AVFoundation
import Vision
import Combine

final class BarcodeScannerViewModel: NSObject, ObservableObject {
    @Published var scannedCode: String?
    
    let captureSession = AVCaptureSession()
    private var isSessionRunning = false
    
    @MainActor func startScanning() async {
        guard !isSessionRunning else { return }
        
        do {
            try await setupCaptureSession()
            try await withCheckedThrowingContinuation { continuation in
                self.captureSession.startRunning()
                self.isSessionRunning = true
                continuation.resume()
            }
            objectWillChange.send()
        } catch {
            print("Ошибка")
        }
    }
    
    func stopScanning() async {
        guard isSessionRunning else { return }
        
        await withCheckedContinuation { continuation in
            self.captureSession.stopRunning()
            self.isSessionRunning = false
            continuation.resume()
        }
    }
    
    // MARK: - Private Methods
    private func setupCaptureSession() async throws {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            throw ScannerError.cameraSetupFailed
        }
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            guard captureSession.canAddInput(videoInput) else {
                continuation.resume(throwing: ScannerError.cameraSetupFailed)
                return
            }
            
            captureSession.addInput(videoInput)
            
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: .main)
            
            guard captureSession.canAddOutput(videoOutput) else {
                continuation.resume(throwing: ScannerError.outputSetupFailed)
                return
            }
            
            captureSession.addOutput(videoOutput)
            continuation.resume()
        }
    }
    
    @MainActor
    private func handleScannedCode(_ code: String) {
        scannedCode = code
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension BarcodeScannerViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    nonisolated func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        detectBarcode(in: pixelBuffer)
    }
    
    private nonisolated func detectBarcode(in pixelBuffer: CVPixelBuffer) {
        let request = VNDetectBarcodesRequest { [weak self] request, _ in
            guard let results = request.results as? [VNBarcodeObservation],
                  let barcode = results.first,
                  let payload = barcode.payloadStringValue else { return }
            
            Task {
                await self?.handleScannedCode(payload)
                await self?.stopScanning()
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up)
        
        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }
}

// MARK: - Scanner Errors
extension BarcodeScannerViewModel {
    enum ScannerError: Error {
        case cameraSetupFailed
        case outputSetupFailed
        
        var localizedDescription: String {
            switch self {
            case .cameraSetupFailed:
                return "Не удалось настроить камеру"
            case .outputSetupFailed:
                return "Не удалось настроить вывод видео"
            }
        }
    }
}
