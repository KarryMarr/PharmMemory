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
    
    @Published var medicine: Medicine
    @Published var sceneType: EditMedicineModel.SceneType
    
    var isValid: Bool {
        !medicine.title.isEmpty && !medicine.dose.isEmpty && !medicine.count.isEmpty
    }
    
    init(
        medicine: Medicine,
        sceneType: EditMedicineModel.SceneType
    ) {
        self.medicine = medicine
        self.sceneType = sceneType
    }
    
    func saveButtonTapped() {
        databaseService?.saveMedicine(medicine)
    }
}
