//
//  ProductModel.swift
//  home_work_5_mont_4
//
//  Created by Аяз on 2/6/23.
//

import UIKit

// MARK: - ProductModel
struct ProductModel: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let thumbnail: String?
    init(id: Int?, title: String?, description: String? = nil, thumbnail: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}
