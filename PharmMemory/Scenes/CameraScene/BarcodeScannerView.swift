//
//  BarcodeScannerView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import SwiftUI

private extension Double {
    static let scannerHeaderBackgroundOpacity = 0.5
}

private extension CGFloat {
    static let scannerHeaderCornerRadius: CGFloat = 8
    static let scannerHeaderTopPadding: CGFloat = 20
}

struct BarcodeScannerView: View {
    @Binding var scannedCode: String?
    var action: () -> Void
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
            scannedCode = viewModel.scannedCode ?? String.empty
            action()
            if scannedCode?.isEmpty == false {
                dismiss()
            }
        }
    }
    
    private var scannerHeader: some View {
        HStack {
            Text("Наведите камеру на штрих-код")
                .foregroundColor(Color.white)
                .padding()
                .background(Color.black.opacity(Double.scannerHeaderBackgroundOpacity))
                .cornerRadius(CGFloat.scannerHeaderCornerRadius)
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black.opacity(Double.scannerHeaderBackgroundOpacity))
                    .clipShape(Circle())
            }
        }
        .padding(.top, CGFloat.scannerHeaderTopPadding)
    }
}
