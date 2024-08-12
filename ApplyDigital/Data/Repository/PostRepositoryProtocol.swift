//
//  PostRepositoryProtocol.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import Foundation

protocol PostRepositoryProtocol {
    func getPostList() async throws -> PostListModel
}
