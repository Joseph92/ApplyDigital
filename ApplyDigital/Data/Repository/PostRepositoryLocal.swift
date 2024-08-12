//
//  PostRepositoryLocal.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 12/08/24.
//

import Foundation

final class PostRepositoryLocal: PostRepositoryProtocol {
    // MARK: Inits
    init () {}

    func getPostList() async throws -> PostListModel {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<PostListModel, Error>) in
            do {
                if let data = UserDefaults.standard.data(forKey: "last_response") {
                    let model = try JSONDecoder().decode(PostListModel.self, from: data)
                    continuation.resume(returning: model)
                } else {
                    continuation.resume(returning: .init(postList: []))
                }
            } catch {
                continuation.resume(returning: .init(postList: []))
            }
        }
    }
}
