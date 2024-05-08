//
//  IconTitleView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

struct IconTitleView: View {
    let viewModel: IconTitleViewModel
    
    var body: some View {
        VStack {
            imageView
            Text(viewModel.title)
                .foregroundStyle(Color.black)
                .font(.footnote)
                .lineLimit(1)
        }
    }
    
    var imageView: some View {
        ZStack {
            Circle()
                .fill(Color.white)
            viewModel.asset.image?
                .resizable()
                .frame(width: 30, height: 30)
        }
        .clipped()
        .frame(width: 50, height: 50)
    }
}

#Preview {
    IconTitleView(
        viewModel: IconTitleViewModel(
            asset: Assets.category,
            title: "Ordinary Drink"
        )
    )
}
