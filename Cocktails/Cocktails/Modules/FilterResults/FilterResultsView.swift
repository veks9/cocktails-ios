//
//  FilterResultsView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import SwiftUI

struct FilterResultsView<ViewModel: FilterResultsViewModeling>: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            cocktailsList
                .background(Color.backgroundPrimary)
                .toolbar(.visible, for: .navigationBar)
                .navigationBarItems(leading: leadingNavigationBarItem)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(Localization.filterResultsNavigationTitle.localized(viewModel.cocktailViewModels.count))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
        }
    }
    
    var leadingNavigationBarItem: some View {
        Button(action: {
            router.navigateToRoot()
        }, label: {
            Assets.back.image
        })
        .frame(width: 40, height: 40)
    }
    
    var cocktailsList: some View {
        List(content: {
            ForEach(viewModel.cocktailViewModels, id: \.id) { cocktailViewModel in
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
