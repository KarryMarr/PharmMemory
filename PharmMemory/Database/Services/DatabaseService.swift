//
//  DatabaseService.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import SwiftData

final class DatabaseService {
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
}
