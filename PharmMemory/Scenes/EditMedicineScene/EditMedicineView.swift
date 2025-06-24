//
//  EditMedicineView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//

import SwiftUI

struct EditMedicineView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EditMedicineViewModel
    @State private var isShowingScanner = false
    @State private var scannedBarcode = ""
    
    var body: some View {
        NavigationStack {
            Form {
                mainSection
                barcodeSection
                additionalSection
            }
            .background(Color.background)
            .navigationTitle("Добавить лекарство")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        viewModel.saveButtonTapped()
                        dismiss()
                    } label: {
                        Text("Сохранить")
                            .foregroundStyle(Color.blue)
                    }
                    .font(.bodyBold)
                    .foregroundColor(.primary)
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                BarcodeScannerView(scannedCode: $scannedBarcode)
            }
        }
    }
}

extension EditMedicineView {
    var mainSection: some View {
        Section {
            TextField("Название лекарства", text: $viewModel.medicine.title)
                .font(.bodyText)
                .foregroundColor(.textPrimary)
            
            TextField("Дозировка (мг, мл и т.д.)", text: $viewModel.medicine.dose)
                .font(.bodyText)
                .foregroundColor(.textPrimary)
                .keyboardType(.numbersAndPunctuation)
            
            TextField("Количество в упаковке", text: $viewModel.medicine.count)
                .font(.bodyText)
                .foregroundColor(.textPrimary)
                .keyboardType(.numberPad)
            
            DatePicker(
                "Срок годности",
                selection: $viewModel.medicine.expiryDate,
                displayedComponents: .date
            )
            .font(.bodyText)
            .foregroundColor(.textPrimary)
        }
        .listRowBackground(Color.cardBackground)
    }
    
    var barcodeSection: some View {
        Section {
            Button(action: {
                isShowingScanner = true
            }) {
                HStack {
                    Image(systemName: "barcode.viewfinder")
                    Text("Сканировать штрих-код")
                        .font(.bodyText)
                }
                .foregroundColor(.blue)
            }
            
            if !scannedBarcode.isEmpty {
                HStack {
                    Text("Штрих-код:")
                        .font(.captionText)
                        .foregroundColor(.textSecondary)
                    Text(scannedBarcode)
                        .font(.bodyText)
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .listRowBackground(Color.cardBackground)
    }
    
    var additionalSection: some View {
        Section(header: Text("Дополнительно").font(.sectionHeader)) {
            TextField("Заметки", text: $viewModel.medicine.notes)
                .font(.bodyText)
                .foregroundColor(.textPrimary)
        }
        .listRowBackground(Color.cardBackground)
    }
}

