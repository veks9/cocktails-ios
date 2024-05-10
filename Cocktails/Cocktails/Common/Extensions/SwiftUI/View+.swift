//
//  View+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 10.05.2024..
//

import SwiftUI

extension View {
    func errorAlert(showError: Binding<Bool>, title: Text, message: Text? = nil, buttonTitle: String = "OK") -> some View {
        return alert(isPresented: showError) {
            return Alert(
                title: title,
                message: message,
                dismissButton: .cancel(Text(buttonTitle)) {}
            )
        }
    }
}
