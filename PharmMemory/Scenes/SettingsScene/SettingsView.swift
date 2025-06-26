//
//  SettingsView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultsKeys.notificationsEnabled.rawValue) private var notificationsEnabled = true
    @AppStorage(UserDefaultsKeys.expiryReminderDays.rawValue) private var expiryReminderDays = 7
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Уведомления").font(.sectionHeader)) {
                    Toggle("Напоминания о сроке годности", isOn: $notificationsEnabled)
                        .font(.bodyText)
                    
                    if notificationsEnabled {
                        Stepper(
                            "Напоминать за \(expiryReminderDays) дней",
                            value: $expiryReminderDays,
                            in: 1...30
                        )
                        .font(.bodyText)
                    }
                }
                
                Section {
                    Button(action: {}) {
                        Text("О приложении")
                            .font(.bodyText)
                            .foregroundColor(.textPrimary)
                    }
                }
            }
            .navigationTitle("Настройки")
            .background(Color.background)
        }
    }
}
