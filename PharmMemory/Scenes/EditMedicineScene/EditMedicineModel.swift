//
//  EditMedicineModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//

struct EditMedicineModel {
    
    enum SceneType {
        case add
        case edit
        
        var title: String {
            switch self {
            case .add:
                return "Добавить лекарство"
            case .edit:
                return "Редактировать лекарство"
            }
        }
    }
}
