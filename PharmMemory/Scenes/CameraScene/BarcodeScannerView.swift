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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ScannerViewRepresentable(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            VStack {
                scannerHeader
                Spacer()
            }
        }
        .task {
            await viewModel.startScanning()
        }
        .onDisappear {
            Task { await viewModel.stopScanning() }
        }
        .onChange(of: viewModel.scannedCode) {
            scannedCode = viewModel.scannedCode
            if !scannedCode.isEmpty {
                dismiss()
            }
        }
    }
    
    private var scannerHeader: some View {
        HStack {
            Spacer()
            
            Text("Наведите камеру на штрих-код")
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}
