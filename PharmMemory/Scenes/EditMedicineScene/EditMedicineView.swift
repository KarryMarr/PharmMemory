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
    
    var body: some View {
        NavigationStack {
            Form {
                mainSection
                barcodeSection
                additionalSection
            }
            .background(Color.background)
            .navigationTitle(viewModel.sceneType.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        viewModel.saveButtonTapped()
                        if viewModel.medicine.isValid {
                            dismiss()
                        }
                    } label: {
                        Text("Сохранить")
                            .foregroundStyle(viewModel.medicine.isValid ? Color.blue : Color.gray)
                    }
                    .alert("Заполните обязательные поля", isPresented: $viewModel.isShowAlert) { }
                    .font(Font.bodyBold)
                    .foregroundColor(Color.primary)
                }
            }
            .sheet(isPresented: $viewModel.isShowingScanner) {
                BarcodeScannerView(scannedCode: $viewModel.medicine.barcode)
            }
        }
    }
}

private extension EditMedicineView {
    var mainSection: some View {
        Section {
            TextField("Название лекарства", text: $viewModel.medicine.title)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
            
            TextField("Дозировка (мг, мл и т.д.)", text: $viewModel.medicine.dose)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
                .keyboardType(.numbersAndPunctuation)
            
            TextField("Количество в упаковке", text: $viewModel.medicine.count)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
                .keyboardType(.numberPad)
            
            DatePicker(
                "Срок годности",
                selection: $viewModel.medicine.expiryDate,
                displayedComponents: .date
            )
            .font(Font.bodyText)
            .foregroundColor(Color.textPrimary)
            .environment(\.locale, Locale(identifier: "ru_RU"))
        }
        .listRowBackground(Color.cardBackground)
    }
    
    var barcodeSection: some View {
        Section {
            if let barcode = viewModel.medicine.barcode {
                HStack {
                    Text("Штрих-код:")
                        .font(Font.captionText)
                        .foregroundColor(Color.textSecondary)
                    Text(barcode)
                        .font(Font.bodyText)
                        .foregroundColor(Color.textPrimary)
                    Spacer()
                    Button {
                        viewModel.copyBarcodeTapped()
                    } label: {
                        Image(systemName: "square.fill.on.square.fill")
                            .foregroundColor(Color.textSecondary)
                    }
                    
                }
            } else {
                Button {
                    viewModel.isShowingScanner = true
                } label: {
                    HStack {
                        Image(systemName: "barcode.viewfinder")
                        Text("Сканировать штрих-код")
                            .font(Font.bodyText)
                    }
                    .foregroundColor(Color.blue)
                }
            }
        }
        .listRowBackground(Color.cardBackground)
    }
    
    var additionalSection: some View {
        Section(header: Text("Дополнительно").font(.sectionHeader)) {
            TextField("Заметки", text: $viewModel.medicine.notes)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
        }
        .listRowBackground(Color.cardBackground)
    }
}

