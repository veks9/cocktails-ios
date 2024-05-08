//
//  CocktailView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI
import Kingfisher

struct CocktailView: View {
    let viewModel: CocktailViewModel
    
    var body: some View {
        HStack(spacing: 8, content: {
            KFImage(viewModel.imageUrl)
                .resizable()
                .frame(width: 70, height: 80)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                if let subtitle = viewModel.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                }
            }
            .padding()
            Spacer()
        })
        .padding()
    }
}

#Preview {
    CocktailView(
        viewModel: CocktailViewModel(
            id: "1",
            title: "Martini",
            subtitle: "A classic Martini is made from gin and vermouth and garnished with either an olive or lemon twist.",
            imageUrl: URL(string: "https://i0.wp.com/www.splashoftaste.com/wp-content/uploads/2022/05/dirty-martini-7-2-768x1024.jpg")
        )
    )
}
