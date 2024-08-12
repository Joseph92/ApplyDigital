//
//  ApplyDigitalApp.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import SwiftUI

@main
struct ApplyDigitalApp: App {
    var body: some Scene {
        WindowGroup {
            PostView(viewModel: PostListViewModel())
        }
    }
}
