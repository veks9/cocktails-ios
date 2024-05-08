//
//  CocktailDetailsView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI
import Kingfisher

struct CocktailDetailsView<ViewModel: CocktailDetailsViewModeling>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    image
                    Spacer()
                }
                VStack {
                    Spacer()
                        .frame(height: 265)
                    VStack(spacing: 15) {
                        topIconsView
                        ingredientsAndMeasuresView
                        directionsView
                        lastModifiedView
                    }
                    .background(Color.backgroundPrimary)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 30,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 30,
                            style: .continuous
                        )
                    )
                }
            }
        }
        .background(Color.backgroundPrimary)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.appPrimary, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.navigationTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var image: some View {
        KFImage(viewModel.thumbnailUrl)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 300)
            .clipped()
    }
    
    @ViewBuilder
    var topIconsView: some View {
        HStack {
            if let categoryIconTitleViewModel = viewModel.categoryIconTitleViewModel {
                IconTitleView(viewModel: categoryIconTitleViewModel)
                    .frame(maxWidth: .infinity)
                Spacer()
                
            }
            if let glassIconTitleViewModel = viewModel.glassIconTitleViewModel {
                IconTitleView(viewModel: glassIconTitleViewModel)
                    .frame(maxWidth: .infinity)
                Spacer()
                
            }
            if let alcoholicTypeIconTitleViewModel = viewModel.alcoholicTypeIconTitleViewModel {
                IconTitleView(viewModel: alcoholicTypeIconTitleViewModel)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding([.top, .leading, .trailing], 20)
        Divider()
    }
    
    @ViewBuilder
    var ingredientsAndMeasuresView: some View {
        if let ingredientsAndMeasures = viewModel.ingredientsAndMeasures {
            VStack(alignment: .leading, spacing: 10) {
                Text("cocktail_details_ingredients_section_title".localized())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(ingredientsAndMeasures)
                    .font(.footnote)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Divider()
        }
    }
    
    @ViewBuilder
    var directionsView: some View {
        if let directions = viewModel.directions {
            VStack(alignment: .leading, spacing: 10) {
                Text("cocktail_details_directions_section_title".localized())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(directions)
                    .font(.footnote)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Divider()
        }
    }
    
    @ViewBuilder
    var lastModifiedView: some View {
        if let lastModifiedFormatted = viewModel.lastModifiedFormatted {
            Text(lastModifiedFormatted)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
}
