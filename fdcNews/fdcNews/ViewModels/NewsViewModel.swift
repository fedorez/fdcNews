//
//  NewsViewModel.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import Foundation

let urlToDefaultImage = "https://www.kindpng.com/picc/m/182-1827064_breaking-news-banner-png-transparent-background-breaking-news.png"

struct NewsViewModel {
    var news: News
    
    var author: String {
        return news.author ?? "Unknown"
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var description: String {
        return news.description ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? urlToDefaultImage
    }
    
    var views: String {
        return "👁\(news.views ?? 0)"
    }
}
