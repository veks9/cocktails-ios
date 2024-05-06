//
//  HomeView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        List(content: {
            CocktailView(viewModel: CocktailViewModel(
                title: "Martini",
                subtitle: "A classic Martini is made from gin and vermouth and garnished with either an olive or lemon twist.",
                imageUrl: URL(string: "https://i0.wp.com/www.splashoftaste.com/wp-content/uploads/2022/05/dirty-martini-7-2-768x1024.jpg")
            ))
                .listRowInsets(EdgeInsets())
        })
        .listStyle(.inset)
        .background(Color.white)
    }
}

#Preview {
    HomeView()
}
