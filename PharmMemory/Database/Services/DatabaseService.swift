//
//  DatabaseService.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import SwiftData

protocol DatabaseServiceProtocol {
    func saveMedicine(_ medicine: Medicine)
    func fetchAllMedicines() -> [Medicine]
}

final class DatabaseService: DatabaseServiceProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveMedicine(_ medicine: Medicine) {
        let dbModel = MedicineDBModel(from: medicine)
        modelContext.insert(dbModel)
        do {
            try modelContext.save()
        } catch {
            print("Saving to the database failed: \(error)")
        }
    }
    
    func fetchAllMedicines() -> [Medicine] {
        let fetchDescriptor = FetchDescriptor<MedicineDBModel>()
        do {
            let dbModels = try modelContext.fetch(fetchDescriptor)
            return dbModels.map { Medicine(from: $0) }
        } catch {
            print("Failed to fetch medicines: \(error)")
            return []
        }
    }
}
