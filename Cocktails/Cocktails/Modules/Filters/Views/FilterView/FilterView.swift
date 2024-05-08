//
//  FilterView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import SwiftUI

struct FilterView: View {
    let viewModel: FilterViewModel
    
    var body: some View {
        HStack(spacing: 8, content: {
            icon
            Text(viewModel.title)
                .foregroundStyle(Color.black)
                .font(.subheadline)
            Spacer()
        })
        .contentShape(Rectangle())
    }
    
    var icon: some View {
        viewModel.isSelected ?
        Assets.radioButtonSelected.image :
        Assets.radioButton.image
    }
}

#Preview {
    FilterView(
        viewModel: FilterViewModel(
            id: "alcoholic",
            title: "alcoholic",
            isSelected: false
        )
    )
}
