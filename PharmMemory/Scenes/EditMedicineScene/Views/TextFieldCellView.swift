//
//  TextFieldCellView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 10.07.2025.
//
import SwiftUI

private extension CGFloat {
    static let mandatoryIconWidthAndHeight: CGFloat = 4
}

struct TextFieldCellView: View {
    let title: String
    @Binding var subtitle: String
    var isMandatory: Bool
    var shouldShowPicker: Bool = false
    @State var selectedUnit: DosageUnits = .milligrams
    var keyboardType: UIKeyboardType = .default
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
            if isMandatory {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: CGFloat.mandatoryIconWidthAndHeight, height: CGFloat.mandatoryIconWidthAndHeight)
                    .foregroundStyle(Color.red)
            }
            Spacer()
            if isEditing || subtitle.isEmpty == false {
                HStack {
                    TextField(String.empty, text: $subtitle)
                        .focused($isFocused)
                        .keyboardType(keyboardType)
                        .environment(\.layoutDirection, .rightToLeft)
                    Button(action: {
                        subtitle = ""
                        isEditing = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.blue)
                }
            } else {
                Button("Указать") {
                    isFocused = true
                    isEditing = true
                }
                .foregroundColor(Color.blue)
            }
            if shouldShowPicker {
                Picker("", selection: $selectedUnit) {
                    ForEach(DosageUnits.allCases, id: \.self) { unit in
                        Text(unit.title).tag(unit)
                    }
                }
                .pickerStyle(.palette)
                .fixedSize()
            }
        }
    }
}
