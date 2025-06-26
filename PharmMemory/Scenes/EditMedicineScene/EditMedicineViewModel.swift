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
    
    @Published var medicine: Medicine
    @Published var sceneType: EditMedicineModel.SceneType
    
    var isValid: Bool {
        !medicine.title.isEmpty && !medicine.dose.isEmpty && !medicine.count.isEmpty
    }
    
    init(
        sceneType: EditMedicineModel.SceneType,
        medicine: Medicine?
    ) {
        self.sceneType = sceneType
        self.medicine = medicine ?? Medicine(
            id: UUID(),
            title: String.empty,
            dose: String.empty,
            count: String.empty,
            notes: String.empty,
            expiryDate: Date())
    }
    
    func saveButtonTapped() {
        databaseService?.saveMedicine(medicine)
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.notificationsEnabled.rawValue) {
            notificationCenterService?.scheduleExpiryNotifications(for: medicine)
        }
    }
}
