//
//  DatabaseService.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import SwiftData
import Foundation

protocol DatabaseServiceProtocol {
    func fetchAllMedicines() -> [Medicine]
    func saveMedicine(_ medicine: Medicine)
    func deleteMedicine(byId id: UUID)
}

final class DatabaseService: DatabaseServiceProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAllMedicines() -> [Medicine] {
        let fetchDescriptor = FetchDescriptor<MedicineDBModel>()
        do {
            let dbModels = try modelContext.fetch(fetchDescriptor)
            return dbModels.map { Medicine(from: $0) }
        } catch {
            print("Failed to fetch medicines: \(error)") //TODO: показать ошибку в тоасте и не закрывать экран
            return []
        }
    }
    
    func saveMedicine(_ medicine: Medicine) {
        let dbModel = MedicineDBModel(from: medicine)
        modelContext.insert(dbModel)
        do {
            try modelContext.save()
        } catch {
            print("Saving to the database failed: \(error)") //TODO: показать ошибку в тоасте и не закрывать экран
        }
    }
    
    func deleteMedicine(byId id: UUID) {
        let predicate = #Predicate<MedicineDBModel> { $0.id == id }
        
        do {
            try modelContext.delete(
                model: MedicineDBModel.self,
                where: predicate
            )
            print("Успешно удалено") //TODO: показать ошибку в тоасте и не закрывать экран
        } catch {
            print("Ошибка удаления: \(error)") //TODO: показать ошибку в тоасте и не закрывать экран
        }
    }
}
