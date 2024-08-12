//
//  PostCellView.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 11/08/24.
//

import SwiftUI

struct PostCellView: View {
    let post: PostModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(post.title ?? "no data")
                    .font(.system(size: 17, weight: .semibold))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Text(post.author ?? "no data")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                Text("-")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                Text(Date(timeIntervalSince1970: TimeInterval(post.createdAt ?? 0)).timeAgoDisplay())
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                Spacer()
            }
        }.padding(.vertical, 10)
    }
}

#Preview {
    PostCellView(post: .init(id: "1234"))
}
