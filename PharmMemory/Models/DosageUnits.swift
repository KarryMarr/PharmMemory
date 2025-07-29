//
//  DosageUnits.swift
//  PharmMemory
//
//  Created by Karina Blinova on 15.07.2025.
//

enum DosageUnits: String, Codable, CaseIterable {
    case milligrams = "мг"
    case percent = "%"
    case grams = "г"
    
    var title: String {
        return self.rawValue
    }
}
