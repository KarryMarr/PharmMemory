//
//  BarcodeScannerView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import SwiftUI

struct BarcodeScannerView: View {
    @Binding var scannedCode: String
    @StateObject var viewModel = BarcodeScannerViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScannerView(scannedCode: $scannedCode)
                .edgesIgnoringSafeArea(.all)
            
            Text(scannedCode)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .padding()
                    .background(Color(.systemBackground).opacity(0.8))
                    .cornerRadius(10)
            }
        }
        .alert("Ошибка", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
                viewModel.resetScanner()
            }
        } message: {
            Text(viewModel.errorMessage ?? "Неизвестная ошибка")
        }
//        .onAppear {
//            viewModel.startScanning()
//        }
//        .onDisappear {
//            viewModel.stopScanning()
//        }
    }
}
