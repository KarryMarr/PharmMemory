//
//  Fonts.swift
//  PharmMemory
//
//  Created by Karina Blinova on 17.06.2025.
//

import SwiftUI

extension Font {
    // Заголовки
    static let largeTitle = Font.system(size: 22, weight: .bold, design: .default)
    static let screenTitle = Font.system(size: 20, weight: .bold, design: .default)
    static let sectionHeader = Font.system(size: 18, weight: .bold, design: .default)
    
    // Основной текст
    static let bodyText = Font.system(size: 16, weight: .regular, design: .default)
    static let bodyBold = Font.system(size: 16, weight: .medium, design: .default)
    
    // Второстепенный текст
    static let captionText = Font.system(size: 14, weight: .light, design: .default)
    static let fieldLabel = Font.system(size: 14, weight: .medium, design: .default)
    
    // Кнопки
    static let buttonText = Font.system(size: 16, weight: .medium, design: .default)
}
