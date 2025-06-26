//
//  PharmMemoryApp.swift
//  PharmMemory
//
//  Created by Karina Blinova on 17.06.2025.
//

import SwiftUI
import SwiftData

@main
struct PharmMemoryApp: App {
    let serviceConstructor: ServiceConstructor
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
                .modelContainer(container)
                .onAppear {
                    requestNotificationPermission()
                }
        }
    }
}

extension PharmMemoryApp {
    init() {
        serviceConstructor = ServiceConstructor()
        do {
            serviceConstructor.loadAllServices()
            container = try ModelContainer(for: MedicineDBModel.self)
            serviceConstructor.loadDatabaseService(with: container.mainContext)
        } catch {
            fatalError("Error initializing SwiftData: \(error)")
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение на уведомления получено")
            } else if let error = error {
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
}
