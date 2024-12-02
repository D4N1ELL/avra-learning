//
//  ProgressView.swift
//  Avra
//
//  Created by Daniel Istrati on 17.10.2024.
//

import SwiftUI

struct ProgressView: View {
    @Binding var isTabBarVisible: Bool
    
    var body: some View {
        Text("Progress")
    }
}

#Preview {
    ProgressView(isTabBarVisible: .constant(true))
}
