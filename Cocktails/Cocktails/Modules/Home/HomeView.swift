//
//  HomeView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModeling>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            cocktailsList
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.appPrimary, for: .navigationBar)
                .toolbar(content: {
                    ToolbarItem(placement: .principal) {
                        SearchBarView(searchText: $viewModel.searchText)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        filterIconView
                    }
                })
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
        }
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
    
    @ViewBuilder
    func getCocktailDetailsView(for id: String) -> some View {
        CocktailDetailsView(
            viewModel: CocktailDetailsViewModel(
                context: CocktailDetailsContext(
                    fetchType: .id(id)
                )
            )
        )
    }
    
    @ViewBuilder
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
