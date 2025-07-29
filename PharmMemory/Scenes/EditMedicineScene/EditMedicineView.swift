//
//  EditMedicineView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import SwiftUI

private extension CGFloat {
    static let mandatoryIconWidthAndHeight: CGFloat = 4
}

struct EditMedicineView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    @ObservedObject var viewModel: EditMedicineViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                mainSection
                additionalSection
                barcodeSection
            }
            .navigationTitle(viewModel.sceneType.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Назад")
                        }
                    }
                }
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
                    .alert(viewModel.alertTitle, isPresented: $viewModel.isShowAlert) { }
                    .confirmationDialog(viewModel.alertTitle, isPresented: $viewModel.isShowConfirmationDialog) {
                        ForEach(viewModel.medicineOptions, id: \.self) { option in
                            Button("\(option.name) \(option.dosage) \(option.dosageUnits)") {
                                viewModel.medicineOptionTapped(option)
                            }
                        }
                        Button("Ввести вручную", role: .cancel) {
                            viewModel.isShowConfirmationDialog.toggle()
                        }
                    }
                    .font(Font.bodyBold)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Готово") {
                        isFocused = false
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowingScanner) {
                BarcodeScannerView(
                    scannedCode: $viewModel.medicine.barcode,
                    action: viewModel.showMedicineOptions)
            }
        }
    }
}

private extension EditMedicineView {
    var mainSection: some View {
        Section {
            TextFieldCellView(
                title: "Название",
                subtitle: $viewModel.medicine.title,
                isMandatory: true)
            .focused($isFocused)
            TextFieldCellView(
                title: "Дозировка",
                subtitle: $viewModel.medicine.dose,
                isMandatory: true,
                shouldShowPicker: true,
                selectedUnit: viewModel.medicine.dosageUnits,
                keyboardType: .numberPad)
            .focused($isFocused)
            TextFieldCellView(
                title: "Количество",
                subtitle: $viewModel.medicine.count,
                isMandatory: false,
                keyboardType: .numberPad)
            .focused($isFocused)
            DatePicker(selection: $viewModel.medicine.expiryDate, displayedComponents: .date) {
                HStack {
                    Text("Срок годности")
                        .font(Font.bodyText)
                        .foregroundColor(Color.textPrimary)
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: CGFloat.mandatoryIconWidthAndHeight, height: CGFloat.mandatoryIconWidthAndHeight)
                        .foregroundStyle(Color.red)
                }
            }
            .environment(\.locale, Locale(identifier: "ru_RU"))
        } footer: {
            Text(viewModel.medicine.statusTitle)
                .foregroundStyle(viewModel.medicine.expiryStatus.statusColor)
        }
    }
    
    var additionalSection: some View {
        Section(header: Text("Дополнительно").font(.sectionHeader)) {
            Toggle("Добавить в список покупок", isOn: $viewModel.medicine.isOnShoppingList)
                .font(.bodyText)
            TextField("Заметки", text: $viewModel.medicine.notes)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
        }
    }
    
    var barcodeSection: some View {
        Section {
            if let barcode = viewModel.medicine.barcode {
                VStack {
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
    }
}
