//
//  PostRepositoryRemote.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import Alamofire
import Foundation

enum PostRepositoryError: Error {
    case decode
    case networking
}

final class PostRepositoryRemote: PostRepositoryProtocol {
    // MARK: Inits
    init () {}

    func getPostList() async throws -> PostListModel {
        let endpoint = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"

        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<PostListModel, Error>) in
            AF.request(endpoint)
                .validate()
                .response { response in
                    switch response.result {
                    case let .success(data):
                        do {
                            if let data = data {
                                let model = try JSONDecoder().decode(PostListModel.self, from: data)
                                self.saveLastResponse(data: data)
                                continuation.resume(returning: model)
                            } else {
                                continuation.resume(throwing: PostRepositoryError.decode)
                            }
                        } catch {
                            continuation.resume(throwing: PostRepositoryError.decode)
                        }
                    case .failure:
                        continuation.resume(throwing: PostRepositoryError.networking)
                    }
                }
        }
    }
}


private extension PostRepositoryRemote {
    func saveLastResponse(data: Data) {
        UserDefaults.standard.setValue(data, forKey: "last_response")
    }
}
