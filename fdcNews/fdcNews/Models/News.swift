//
//  News.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import Foundation

struct News: Decodable, Encodable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    var views: Int?
}

struct NewsEnvelop: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
