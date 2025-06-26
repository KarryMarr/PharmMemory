//
//  NotificationCenterService.swift
//  PharmMemory
//
//  Created by Karina Blinova on 25.06.2025.
//
import UserNotifications

protocol NotificationCenterServiceProtocol {
    func scheduleExpiryNotifications(for medicine: Medicine)
}

final class NotificationCenterService: NotificationCenterServiceProtocol {
    func scheduleExpiryNotifications(for medicine: Medicine) {
        let notificationCenter = UNUserNotificationCenter.current()
        let expiryReminderDays = UserDefaults.standard.integer(forKey: UserDefaultsKeys.expiryReminderDays.rawValue)
        guard let warningDate = Calendar.current.date(
            byAdding: .day,
            value: -expiryReminderDays,
            to: medicine.expiryDate) else { return }
        
        if warningDate < Date() {
            print("Срок предупреждения уже прошел")
            return
        }
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: warningDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Срок годности истекает"
        content.body = "Лекарство \(medicine.title) нужно заменить через \(expiryReminderDays) дней!"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: medicine.id.description,
            content: content,
            trigger: trigger
        )
        
        notificationCenter.add(request)
    }
}
