//
//  HomeView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModeling>: View {
    @StateObject var viewModel: ViewModel
    @FocusState var isSearchBarFocused: Bool
    @State var isFilterButtonShown: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                topView
                cocktailsList
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
            withAnimation {
                isFilterButtonShown = !isSearchBarFocused
            }
        }
    }
    
    var filterIconView: some View {
        NavigationLink {
            FiltersView(viewModel: FiltersViewModel())
        } label: {
            Assets.filter.image?
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    var topView: some View {
        VStack {
            HStack {
                searchBarView
                if isFilterButtonShown {
                    filterIconView
                }
            }
        }
        .padding(.all, 10)
        .background(Color.appPrimary)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    var cocktailsList: some View {
        List(content: {
            ForEach(viewModel.cocktailViewModels, id: \.id) { cocktailViewModel in
                ZStack {
                    CocktailView(viewModel: cocktailViewModel)
                    NavigationLink(destination: getCocktailDetailsView(for: cocktailViewModel.id)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.backgroundPrimary)
            }
        })
        .safeAreaInset(edge: .bottom) {
            floatingButton
                .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .listStyle(.plain)
        .background(Color.backgroundPrimary)
    }
    
    var floatingButton: some View {
        NavigationLink {
            getCocktailDetailsView()
        } label: {
            Text("home_floating_button_title".localized().uppercased())
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 40)
        }
        .frame(height: 45)
        .background(Color.appPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 22.5))
    }
    
    func getCocktailDetailsView(for id: String) -> some View {
        CocktailDetailsView(
            viewModel: CocktailDetailsViewModel(
                context: CocktailDetailsContext(
                    fetchType: .id(id)
                )
            )
        )
    }
    
    func getCocktailDetailsView() -> some View {
        CocktailDetailsView(
            viewModel: CocktailDetailsViewModel(
                context: CocktailDetailsContext(
                    fetchType: .random
                )
            )
        )
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
