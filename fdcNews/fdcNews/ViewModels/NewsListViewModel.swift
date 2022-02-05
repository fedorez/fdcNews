//
//  NewsListViewModel.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import Foundation
import Metal

class NewsListViewModel {
    
    var newsVM = [NewsViewModel]()
    private var storage = UserDefaults.standard
    
    // Ключ, по которому будет происходить сохранение и загрузка хранилища из User Defaults
    let storageKey: String = "fdcnews"
    
    var pageFethched: Int = 1 {
        didSet {
            print("Page fetched set to \(pageFethched)")
        }
    }
    
    
    let reuseID = "news"
    
    func getNews(completion: @escaping ([NewsViewModel]) -> Void) {
        pageFethched = 1
        NetworkManager.shared.getNews { (news) in
            guard let news = news else {
                return
            }
            let newsVM = news.map(NewsViewModel.init)
            DispatchQueue.main.async {
                self.newsVM = newsVM
                self.saveNews()
                completion(newsVM)
            }
        }
    }
    
    func getNewsCold(completion: @escaping ([NewsViewModel]) -> Void) {
        if let data = UserDefaults.standard.value(forKey:storageKey) as? Data {
            let news = try? PropertyListDecoder().decode(Array<News>.self, from: data)
            guard let news = news else {
                return
            }
            let newsVM = news.map(NewsViewModel.init)
            DispatchQueue.main.async {
                self.newsVM = newsVM
                completion(newsVM)
            }
        }
    }
    
    func getNewsPage(completion: @escaping ([NewsViewModel]) -> Void) {
        NetworkManager.shared.getNewsFromPage(page: pageFethched+1) { (news) in
            guard let news = news else {
                return
            }
            if news.count > 0 {
                let newsVM = news.map(NewsViewModel.init)
                self.pageFethched+=1
                DispatchQueue.main.async {
                    self.newsVM.append(contentsOf: newsVM)
                    self.saveNews()
                    completion(newsVM)
                }
            } else {
                return
            }
        }
    }
    
    func saveNews () {
        var newsToSave = [News]()
        for currNewsVM in newsVM {
            newsToSave.append(currNewsVM.news)
        }
        guard newsToSave.count > 0 else {
            return
        }
        storage.set(try? PropertyListEncoder().encode(newsToSave), forKey: storageKey)
    }
    
}
