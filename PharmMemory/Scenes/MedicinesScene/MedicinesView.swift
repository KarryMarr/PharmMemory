//
//  MedicinesView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 17.06.2025.
//

import SwiftUI

struct MedicinesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = MedicinesViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredMedicines) { element in
                MedicineCardView(medicine: element)
                    .listRowBackground(Color.cardBackground)
                    .listRowSeparatorTint(Color.separator)
            }
            .navigationBarTitle("Моя аптечка")
            .toolbar {
                toolbarButton
            }
            .task {
                viewModel.fetchMedicines()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Найти лекарство")
    }
}

private extension MedicinesView {
    private var toolbarButton: some View {
        NavigationLink {
            EditMedicineView(viewModel: EditMedicineViewModel(
                medicine: Medicine.empty,
                sceneType: .add))
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
        }
    }
}
