//
//  CheckListViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

final class CheckListViewModel: ObservableObject {
    private let databaseService = ServiceLocator.shared.resolve(DatabaseServiceProtocol.self)
    
    @Published var medicines: [Medicine] = []
    @Published var model = CheckListModel(state: .empty)
    
    func onAppear() {
        let medicines = databaseService?.fetchAllMedicines() ?? []
        self.medicines = medicines.filter { $0.isOnShoppingList }
        model.state = medicines.isEmpty ? .empty : .content
    }
}
