//
//  PostView.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import SwiftUI
import WebKit

struct PostView<ViewModel>: View where ViewModel: PostListViewModelProtocol {
    // MARK: Properties
    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            content
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .preferredColorScheme(.light)
        .onViewDidLoad(perform: {
            viewModel.load()
        })
    }
}

extension PostView {
    var content: some View {
        AsyncContentView(source: viewModel) { data in
            List {
                ForEach(data, id: \.self) { post in
                    NavigationLink {
                        VStack {
                            Text(post.title ?? "no data")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HTMLStringView(htmlContent: post.body ?? "no data")
                        }
                        .padding(.horizontal)
                        .navigationTitle("Detail")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        PostCellView(post: post)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Posts")
            .refreshable {
                viewModel.fetchPost()
            }
        }
    }
}

private extension PostView {
    func delete(at offsets: IndexSet) {
        //users.remove(atOffsets: offsets)
        viewModel.removePost(at: (offsets.first ?? 0) as Int)
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

#Preview {
    PostView(viewModel: PostListViewModel())
}
