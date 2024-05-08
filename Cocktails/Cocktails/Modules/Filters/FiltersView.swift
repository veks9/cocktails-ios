//
//  FiltersView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

struct FiltersView<ViewModel: FiltersViewModeling>: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        filtersList
            .background(Color.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.appPrimary, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leadingNavigationBarItem)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("filters_navigation_title".localized())
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingToolbarItem
                }
            }
            .preferredColorScheme(.light)
    }
    
    var leadingNavigationBarItem: some View {
        Assets.back.image?
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
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
            Text("filters_trailing_button_title".localized())
                .foregroundStyle(
                    viewModel.isResetButtonDisabled ?
                    Color.appDisabled :
                    Color.white
                )
        })
        .disabled(viewModel.isResetButtonDisabled)
    }
    
    var floatingButton: some View {
        NavigationLink {
            Circle()
        } label: {
            Text("filters_floating_button_title".localized().uppercased())
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(
                    viewModel.isFloatingButtonDisabled ?
                    Color.lightGray :
                    Color.white
                )
                .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
        }
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
