//
//  ServiceConstructor.swift
//  PharmMemory
//
//  Created by Karina Blinova on 21.06.2025.
//
import SwiftData

final class ServiceConstructor {
    private let container = ServiceLocator.shared
    
    func loadAllServices() {
        container.register(NotificationCenterService(), for: NotificationCenterServiceProtocol.self)
        container.register(AutocompleteService(), for: AutocompleteServiceProtocol.self)
    }
    
    func loadDatabaseService(with modelContext: ModelContext) {
        container.register(DatabaseService(modelContext: modelContext), for: DatabaseServiceProtocol.self)
    }
}
