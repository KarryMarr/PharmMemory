//
//  EditMedicineViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import SwiftUI
import SwiftData

final class EditMedicineViewModel: ObservableObject {
    private let databaseService = ServiceLocator.shared.resolve(DatabaseServiceProtocol.self)
    private let notificationCenterService = ServiceLocator.shared.resolve(NotificationCenterServiceProtocol.self)
    private let autocompleteService = ServiceLocator.shared.resolve(AutocompleteServiceProtocol.self)
    
    @Published var medicine: Medicine
    @Published var sceneType: EditMedicineModel.SceneType
    @Published var isShowingScanner = false
    @Published var isShowAlert: Bool = false
    @Published var isShowConfirmationDialog: Bool = false
    @Published var alertTitle: String = String.empty
    @Published var medicineOptions: [MedicineOption] = []
    
    init(
        sceneType: EditMedicineModel.SceneType,
        medicine: Medicine?
    ) {
        self.sceneType = sceneType
        self.medicine = medicine ?? Medicine(
            id: UUID(),
            title: String.empty,
            dose: String.empty,
            dosageUnits: .milligrams,
            count: String.empty,
            notes: String.empty,
            expiryDate: Date(),
            isOnShoppingList: false)
    }
    
    func saveButtonTapped() {
        guard medicine.isValid else {
            alertTitle = "Заполните обязательные поля"
            isShowAlert = true
            return
        }
        databaseService?.saveMedicine(medicine)
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.notificationsEnabled.rawValue) {
            notificationCenterService?.scheduleExpiryNotifications(for: medicine)
        }
        if medicine.barcode?.isEmpty == false {
            Task {
                await autocompleteService?.saveNewMedicine(medicine)
            }
        }
    }
    
    func copyBarcodeTapped() {
        UIPasteboard.general.string = medicine.barcode
        alertTitle = "Артикул скопирован"
        isShowAlert = true
    }
    
    func medicineOptionTapped(_ option: MedicineOption) {
        medicine.title = option.name
        medicine.dose = option.dosage
        medicine.dosageUnits = DosageUnits(rawValue: option.dosageUnits) ?? .milligrams
        medicineOptions = []
    }
    
    func showMedicineOptions() {
        guard let barcode = medicine.barcode else { return }
        Task { @MainActor [weak self] in
            self?.medicineOptions = await self?.autocompleteService?.getMedicines(by: barcode) ?? []
            self?.alertTitle = "Выбери вариант для автозаполнения"
            self?.isShowConfirmationDialog.toggle()
        }
    }
}
