//
//  MedicinesView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 17.06.2025.
//

import SwiftUI

struct MedicinesView: View {
    @StateObject private var viewModel = MedicinesViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredMedicines) { element in
                MedicineCardView(medicine: element)
                    .listRowBackground(Color.cardBackground)
                    .listRowSeparatorTint(Color.separator)
                    .swipeActions {
                        Button {
                            viewModel.deleteMedicine(element)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
            }
            addButton
            .navigationBarTitle("Моя аптечка")
            .task {
                viewModel.fetchMedicines()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Найти лекарство")
    }
}

private extension MedicinesView {
    private var addButton: some View {
        HStack {
            Spacer()
            NavigationLink {
                EditMedicineView(viewModel: EditMedicineViewModel(
                    sceneType: .add,
                    medicine: nil))
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 34, height: 34)
                    .padding()
                    .tint(Color.white)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .padding(.trailing, 30)
                    .padding(.bottom, 30)
            }
        }
    }
}
