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
            CocktailsListView(cocktailViewModels: viewModel.cocktailViewModels)
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
}
