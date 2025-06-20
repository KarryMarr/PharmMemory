//
//  CameraView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import SwiftUI

struct CameraView: View {
    @Binding var scannedCode: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Наведите камеру на штрих-код")
                .font(.bodyText)
                .padding()
            
            // Здесь должна быть реализация сканера через AVFoundation
            // Заглушка для примера:
            Rectangle()
                .frame(height: 200)
                .foregroundColor(.cardBackground)
                .overlay(
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 60))
                        .foregroundColor(.primary)
                )
                .padding()
            
            Button("Отмена") {
                dismiss()
            }
            .font(.bodyText)
            .foregroundColor(.primary)
            .padding()
        }
        .background(Color.background)
    }
}
