//
//  CocktailsListView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import SwiftUI

struct CocktailsListView: View {
    @EnvironmentObject var router: Router
    let cocktailViewModels: [CocktailViewModel]
    
    var body: some View {
        List(content: {
            ForEach(cocktailViewModels) { cocktailViewModel in
                ZStack {
                    CocktailView(viewModel: cocktailViewModel)
                        .onTapGesture {
                            router.navigate(
                                to: .cocktailDetails(
                                    viewModel: CocktailDetailsViewModel(
                                        context: CocktailDetailsContext(
                                            fetchType: .id(cocktailViewModel.id)
                                        )
                                    )
                                )
                            )
                        }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.backgroundPrimary)
            }
            Spacer()
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.backgroundPrimary)
                .listRowSeparator(.hidden)
                .frame(height: 70)
        })
        .listStyle(.plain)
        .background(Color.backgroundPrimary)
    }
}
