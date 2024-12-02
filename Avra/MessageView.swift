//
//  MessageView.swift
//  Avra
//
//  Created by Daniel Istrati on 17.10.2024.
//

import SwiftUI

struct MessageView: View {
    @Binding var isTabBarVisible: Bool
    
    var body: some View {
        Text("Messages")
    }
}

#Preview {
    MessageView(isTabBarVisible: .constant(true))
}
