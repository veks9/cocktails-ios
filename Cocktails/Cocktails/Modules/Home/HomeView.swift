//
//  HomeView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModeling>: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ViewModel
    @FocusState var isSearchBarFocused: Bool
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    CocktailsListView(cocktailViewModels: viewModel.cocktailViewModels)
                        .scrollDismissesKeyboard(.interactively)
                        .padding(.top, geometry.safeAreaInsets.top + 50)
                    VStack(spacing: 0) {
                        Color.appPrimary
                            .frame(height: geometry.safeAreaInsets.top)
                        topView
                        Spacer()
                        floatingButton
                            .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
                    }
                }
                .ignoresSafeArea(.all)
                .background(Color.backgroundPrimary)
                .toolbar(.hidden, for: .navigationBar)
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
    }
    
    var searchBarView: some View {
        SearchBarView(
            searchText: $viewModel.searchText,
            isFocused: $isSearchBarFocused
        )
        .onChange(of: isSearchBarFocused) { _, newValue in
            viewModel.onSearchBarFocusChange(newValue)
        }
    }
    
    var filterIconView: some View {
        Button(action: {
            router.navigate(to: .filters(viewModel: FiltersViewModel()))
        }, label: {
            Assets.filter.image?
                .resizable()
                .frame(width: 20, height: 20)
        })
    }
    
    var topView: some View {
        VStack {
            HStack {
                searchBarView
                if viewModel.isFilterButtonShown {
                    filterIconView
                }
            }
        }
        .padding(.all, 10)
        .background(Color.appPrimary)
        .compositingGroup()
        .shadow(radius: 10)
    }
    
    var floatingButton: some View {
        Button(action: {
            router.navigate(
                to: .cocktailDetails(
                    viewModel: CocktailDetailsViewModel(
                        context: CocktailDetailsContext(
                            fetchType: .random
                        )
                    )
                )
            )
        }, label: {
            Text(Localization.homeFloatingButtonTitle.localized().uppercased())
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
                .frame(height: 45)
                .padding(.horizontal, 40)
        })
        .background(Color.appPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 22.5))
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
