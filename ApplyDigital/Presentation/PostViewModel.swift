//
//  PostViewModel.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import SwiftUI

protocol PostListViewModelProtocol: LoadableProtocol where Output == [PostModel] {
    func fetchPost()
    func removePost(at index: Int)
}

final class PostListViewModel: PostListViewModelProtocol {
    // MARK: Published Properties
    @Published private(set) var state: LoadingState<[PostModel]>
    private var model: [PostModel] = []
    private var removedElements: [String] = []

    // MARK: Properties
    private var fetchPostUseCase: PostFetchUseCaseProtocol

    init(fetchPostUseCase: PostFetchUseCaseProtocol = PostFetchUseCase()) {
        
        self.fetchPostUseCase = fetchPostUseCase
        self.state = .idle
    }

    // MARK: Methods
    func load() {
        fetchPost()
    }

    func fetchPost() {
        Task {
            state = .loading
            do {
                let result = try await self.fetchPostUseCase.fetchPosts()
                model = refreshElements(result)
                DispatchQueue.main.async {
                    if self.model.isEmpty {
                        self.state = .empty
                    } else {
                        self.state = .loaded(self.model)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .failed
                }
            }
        }
    }

    func removePost(at index: Int) {
        let post = model.remove(at: index)
        removedElements.append(post.id)
    }
}

private extension PostListViewModel {
    func refreshElements(_ elements: [PostModel]) -> [PostModel] {
        var temp = elements
        temp.removeAll { post in
            removedElements.contains(post.id)
        }
        return temp
    }
}
