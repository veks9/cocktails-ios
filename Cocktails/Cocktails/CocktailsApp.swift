//
//  CocktailsApp.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI

@main
struct CocktailsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
            // TODO: - this is not working
                .onAppear {
                    UINavigationBar.appearance().backIndicatorImage = Assets.back.uiImage
                    UINavigationBar.appearance().backIndicatorTransitionMaskImage = Assets.back.uiImage
                }
        }
    }
}
