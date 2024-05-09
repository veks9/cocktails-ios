//
//  LoadingView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.appPrimary
                .ignoresSafeArea(.all)
            VStack(spacing: 30) {
                Text(Localization.loadingViewTitle.localized())
                    .foregroundStyle(Color.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Assets.cocktail.image
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    LoadingView()
}
