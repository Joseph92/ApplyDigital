//
//  ViewDidLoadModifier.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    // MARK: Properties
    @State private var viewDidLoad = false
    let action: (() -> Void)?

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
