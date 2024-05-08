//
//  SearchBarView.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 8, content: {
            searchIcon
            TextField("Type to search", text: $searchText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Spacer()
            cancelButton
        })
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 4))
        .frame(height: 35)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var searchIcon: some View {
        Assets.search.image?
            .resizable()
            .renderingMode(.original)
            .frame(width: 15, height: 15)
    }
    
    var cancelButton: some View {
        Button(action: {
            searchText = ""
        }, label: {
            ZStack {
                Circle()
                    .fill(Color.lightGray)
                    .frame(width: 15, height: 15)
                Assets.searchCancel.image?
                    .resizable()
                    .renderingMode(.original)
                    .padding(.all, 4)
            }
        })
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}


