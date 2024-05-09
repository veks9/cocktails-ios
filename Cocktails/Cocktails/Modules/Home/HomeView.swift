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
            ZStack {
                VStack(spacing: 0) {
                    topView
                    cocktailsList
                }
                VStack {
                    Spacer()
                    floatingButton
                        .padding()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
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
        .background(
            Color.appPrimary
        )
    }
    
    var cocktailsList: some View {
        List(
            content: {
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
        .scrollDismissesKeyboard(.interactively)
        .listStyle(.plain)
        .background(Color.backgroundPrimary)
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
