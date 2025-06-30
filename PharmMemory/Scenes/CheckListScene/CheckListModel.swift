//
//  CheckListModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 28.06.2025.
//

struct CheckListModel {
    var state: CheckListState
    
    enum CheckListState {
        case empty, content
    }
}
