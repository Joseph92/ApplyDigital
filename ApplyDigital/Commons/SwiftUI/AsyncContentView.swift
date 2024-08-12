//
//  AsyncContentView.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import SwiftUI

enum LoadingState<Value> {
    case idle
    case loading
    case failed
    case loaded(Value)
    case empty
}

protocol LoadableProtocol: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableProtocol, Content: View>: View {
    // MARK: Properties
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content

    // MARK: Inits
    init(source: Source,
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }

    // MARK: Body
    var body: some View {
        switch source.state {
        case .idle:
            Color.white
        case .loading:
            LoadingView()
        case .failed:
            ZStack {
                Color.red
                    .ignoresSafeArea()
                Text("No connection")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.black)
            }
        case .loaded(let output):
            content(output)
        case .empty:
            ZStack {
                Color.white
                    .ignoresSafeArea()
                Text("No Posts")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.black)
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(2.0, anchor: .center)
    }
}
