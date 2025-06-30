//
//  MedicineListView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 17.06.2025.
//
import SwiftUI

private extension CGFloat {
    static let addButtonPadding: CGFloat = 30
    static let addButtonWidth: CGFloat = 34
    static let addButtonHeight: CGFloat = 34
}

struct MedicineListView: View {
    @StateObject private var viewModel = MedicineListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List(viewModel.filteredMedicines) { element in
                    NavigationLink {
                        EditMedicineView(viewModel: EditMedicineViewModel(
                            sceneType: .edit,
                            medicine: element))
                    } label: {
                        MedicineCardView(medicine: element)
                            .swipeActions {
                                Button {
                                    viewModel.deleteMedicine(element)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color.red)
                            }
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
}

private extension MedicineListView {
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
                    .frame(width: CGFloat.addButtonWidth, height: CGFloat.addButtonHeight)
                    .padding()
                    .tint(Color.white)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .padding(.trailing, CGFloat.addButtonPadding)
                    .padding(.bottom, CGFloat.addButtonPadding)
            }
        }
    }
}
