//
//  FilterResultsView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import SwiftUI

struct FilterResultsView<ViewModel: FilterResultsViewModeling>: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: ViewModel
    
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
                .alert(isPresented: $viewModel.showError, content: {
                    Alert(
                        title: Text(Localization.errorTitle.localized()),
                        message: nil,
                        primaryButton: .cancel(Text("OK")),
                        secondaryButton: .default(Text(Localization.errorTryAgainButtonTitle.localized())) {
                            viewModel.onTryAgainButtonTap()
                        }
                    )
                })
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
