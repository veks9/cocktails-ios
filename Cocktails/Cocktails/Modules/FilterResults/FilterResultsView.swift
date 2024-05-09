//
//  FilterResultsView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import SwiftUI

struct FilterResultsView<ViewModel: FilterResultsViewModeling>: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            cocktailsList
                .background(Color.backgroundPrimary)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.appPrimary, for: .navigationBar)
                .navigationBarBackButtonHidden(true)
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
        Assets.back.image?
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
            .frame(width: 40, height: 40)
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
            Spacer()
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.backgroundPrimary)
                .listRowSeparator(.hidden)
                .frame(height: 70)
        })
        .listStyle(.plain)
        .background(Color.backgroundPrimary)
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
}
