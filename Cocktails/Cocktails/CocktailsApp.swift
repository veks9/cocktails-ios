//
//  CocktailsApp.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI

@main
struct CocktailsApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                HomeView(viewModel: HomeViewModel())
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .cocktailDetails(let viewModel):
                            CocktailDetailsView(viewModel: viewModel)
                                .toolbarBackground(.visible, for: .navigationBar)
                                .toolbarBackground(Color.appPrimary, for: .navigationBar)
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden(true)
                        case .filters(let viewModel):
                            FiltersView(viewModel: viewModel)
                                .toolbarBackground(.visible, for: .navigationBar)
                                .toolbarBackground(Color.appPrimary, for: .navigationBar)
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden(true)
                        case .filterResults(let viewModel):
                            FilterResultsView(viewModel: viewModel)
                                .toolbarBackground(.visible, for: .navigationBar)
                                .toolbarBackground(Color.appPrimary, for: .navigationBar)
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .preferredColorScheme(.light)
            .environmentObject(router)
        }
    }
}
