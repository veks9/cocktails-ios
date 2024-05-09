//
//  CocktailDetailsView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI
import Kingfisher

struct CocktailDetailsView<ViewModel: CocktailDetailsViewModeling>: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ViewModel
    private let imageHeight: CGFloat = 300
    
    var body: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            ScrollView {
                ZStack {
                    VStack {
                        image
                        Spacer()
                    }
                    mainView
                }
            }
            .background(Color.backgroundPrimary)
            .toolbar(.visible, for: .navigationBar)
            .navigationBarItems(leading: leadingNavigationBarItem)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.navigationTitle)
                        .foregroundStyle(Color.white)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
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
    
    var image: some View {
        KFImage(viewModel.thumbnailUrl)
            .placeholder { Assets.cocktail.image }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: imageHeight)
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
                Text(Localization.cocktailDetailsIngredientsSectionTitle.localized())
                    .foregroundStyle(Color.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(ingredientsAndMeasures)
                    .foregroundStyle(Color.black)
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
                Text(Localization.cocktailDetailsDirectionsSectionTitle.localized())
                    .foregroundStyle(Color.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(directions)
                    .foregroundStyle(Color.black)
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
                .foregroundStyle(Color.black)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
    
    var mainView: some View {
        VStack {
            Spacer()
                .frame(height: imageHeight - 35)
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
