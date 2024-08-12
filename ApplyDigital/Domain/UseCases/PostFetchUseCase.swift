//
//  PostFetchUseCase.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import Foundation

protocol PostFetchUseCaseProtocol {
    func fetchPosts() async throws -> [PostModel]
}

final class PostFetchUseCase: PostFetchUseCaseProtocol {
    // MARK: Properties
    private let dataManager: PostDataManagerProtocol

    // MARK: Inits
    init(dataManager: PostDataManagerProtocol = PostDataManager(repositoryRemote: PostRepositoryRemote(),
                                                                repositoryLocal: PostRepositoryLocal())) {
        self.dataManager = dataManager
    }

    // MARK: Methods
    func fetchPosts() async throws -> [PostModel] {
        do {
            return try await dataManager.getPostList().postList
        } catch let error {
            throw error
        }
    }
}
