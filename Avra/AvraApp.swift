//
//  AvraApp.swift
//  Avra
//
//  Created by Daniel Istrati on 16.10.2024.
//

import SwiftUI
import ClerkSDK

@main
struct AvraApp: App {
  @ObservedObject private var clerk = Clerk.shared

  var body: some Scene {
    WindowGroup {
      ZStack {
        if clerk.loadingState == .notLoaded {
            ProgressView()
        } else {
            
          ProfileView()
        }
      }
      .task {
        clerk.configure(publishableKey: "pk_test_dG9wLXdyZW4tOTQuY2xlcmsuYWNjb3VudHMuZGV2JA")
        try? await clerk.load()
      }
    }
  }
}
