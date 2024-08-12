//
//  PostDataManagerProtocol.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import Foundation
import Network

protocol PostDataManagerProtocol {
    func getPostList() async throws -> PostListModel
}

final class PostDataManager: PostDataManagerProtocol {
    // MARK: Properties
    let monitor = NWPathMonitor()
    var repositoryRemote: PostRepositoryProtocol
    var repositoryLocal: PostRepositoryProtocol

    // MARK: Inits
    init(repositoryRemote: PostRepositoryProtocol, repositoryLocal: PostRepositoryProtocol) {
        self.repositoryRemote = repositoryRemote
        self.repositoryLocal = repositoryLocal
        monitor.start(queue: DispatchQueue(label: "NSPathMonitor.paths"))
    }

    // MARK: Methods
    func getPostList() async throws -> PostListModel {
        for await path in monitor {
            if path.status == .satisfied {
                return try await repositoryRemote.getPostList()
            } else {
                return try await repositoryLocal.getPostList()
            }
        }
        return try await repositoryLocal.getPostList()
    }
}
