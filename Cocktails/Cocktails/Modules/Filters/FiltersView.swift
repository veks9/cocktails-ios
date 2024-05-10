//
//  FiltersView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

struct FiltersView<ViewModel: FiltersViewModeling>: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            filtersList
                .background(Color.backgroundPrimary)
                .toolbar(.visible, for: .navigationBar)
                .navigationBarItems(leading: leadingNavigationBarItem)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(Localization.filtersNavigationTitle.localized())
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        trailingToolbarItem
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
            router.navigateBack()
        }, label: {
            Assets.back.image
        })
        .frame(width: 40, height: 40)
    }
    
    var filtersList: some View {
        List {
            ForEach(viewModel.dataSource) { section in
                Section {
                    ForEach(section.items) { item in
                        switch item {
                        case .filter(let viewModel):
                            FilterView(viewModel: viewModel)
                                .listRowBackground(Color.backgroundPrimary)
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    switch section.section {
                                    case .alcoholic:
                                        self.viewModel.onAlcoholicFilterViewTap(with: viewModel.id)
                                    case .category:
                                        self.viewModel.onCategoryFilterViewTap(with: viewModel.id)
                                    case .glass:
                                        self.viewModel.onGlassFilterViewTap(with: viewModel.id)
                                    }
                                }
                        }
                    }
                } header: {
                    Text(section.section.title + ":")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .listSectionSeparator(.visible, edges: .bottom)
            }
        }
        .listStyle(.plain)
        .safeAreaInset(edge: .bottom) {
            floatingButton
        }
    }
    
    var trailingToolbarItem: some View {
        Button(action: {
            viewModel.onResetButtonTap()
        }, label: {
            Text(Localization.filtersTrailingButtonTitle.localized())
                .foregroundStyle(
                    viewModel.isResetButtonDisabled ?
                    Color.appDisabled :
                    Color.white
                )
        })
        .disabled(viewModel.isResetButtonDisabled)
    }
    
    var floatingButton: some View {
        Button(action: {
            router.navigate(to: .filterResults(viewModel: viewModel.filterResultsViewModel))
        }, label: {
            Text(Localization.filtersFloatingButtonTitle.localized().uppercased())
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(
                    viewModel.isFloatingButtonDisabled ?
                    Color.lightGray :
                    Color.white
                )
                .frame(height: 45)
                .frame(maxWidth: .infinity)
        })
        .disabled(viewModel.isFloatingButtonDisabled)
        .background(
            viewModel.isFloatingButtonDisabled ?
            Color.appDisabled :
            Color.appPrimary
        )
        .clipShape(RoundedRectangle(cornerRadius: 22.5))
        .padding()
    }
}
