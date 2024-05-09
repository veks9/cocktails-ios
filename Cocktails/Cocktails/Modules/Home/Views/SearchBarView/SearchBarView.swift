//
//  SearchBarView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 8, content: {
            searchIcon
            textField
            Spacer()
            if !searchText.isEmpty {
                cancelButton
            }
        })
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 4))
        .frame(height: 40)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var searchIcon: some View {
        Assets.search.image?
            .resizable()
            .renderingMode(.original)
            .frame(width: 15, height: 15)
    }
    
    var placeholderView: Text {
        Text(
            isFocused ?
            Localization.searchBarFocusedPlaceholder.localized() :
                Localization.searchBarPlaceholder.localized()
        )
            .foregroundColor(.gray)
    }
    
    var textField: some View {
        TextField(
            "",
            text: $searchText,
            prompt: placeholderView
        )
        .foregroundStyle(Color.black)
        .focused($isFocused)
        .submitLabel(.search)
        .keyboardType(.alphabet)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
    
    var cancelButton: some View {
        Button(action: {
            searchText = ""
        }, label: {
            ZStack {
                Circle()
                    .fill(Color.lightGray)
                    .padding(.all, 5)
                Assets.searchCancel.image?
                    .resizable()
                    .renderingMode(.original)
                    .padding(.all, 10)
            }
            .frame(width: 30, height: 30)
        })
    }
}
