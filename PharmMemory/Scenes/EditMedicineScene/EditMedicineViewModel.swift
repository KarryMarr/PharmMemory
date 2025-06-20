//
//  EditMedicineViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import SwiftUI
import SwiftData

final class EditMedicineViewModel: ObservableObject {
    @Published var medicine: Medicine
    @Published var sceneType: EditMedicineModel.SceneType
    
    private let modelContext: ModelContext
    private let databaseService: DatabaseService
    
    var isValid: Bool {
        !medicine.title.isEmpty && !medicine.dose.isEmpty && !medicine.count.isEmpty
    }
    
    init(
        medicine: Medicine,
        sceneType: EditMedicineModel.SceneType,
        modelContext: ModelContext
    ) {
        self.medicine = medicine
        self.sceneType = sceneType
        self.modelContext = modelContext
        self.databaseService = DatabaseService(modelContext: modelContext)
        setup()
    }
    
    private func setup() {
        
    }
    
    func saveButtonTapped() {
        databaseService.saveMedicine(medicine)
    }
}
