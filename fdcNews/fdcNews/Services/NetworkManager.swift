//
//  NetworkManager.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import Foundation

class NetworkManager {
    
    let imageCache = NSCache<NSString, NSData>()
    
    //it's singletone!!
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private let baseURLString: String = "https://newsapi.org/v2/"
    private let USTopHeadline: String = "top-headlines?country=ru"
    
    func getNews(completion: @escaping ([News]?) ->Void) {
        let urlString = "\(baseURLString)\(USTopHeadline)&apiKey=\(APIKey.key)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let newsEnvelope = try? JSONDecoder().decode(NewsEnvelop.self, from: data)
            newsEnvelope == nil ? completion(nil) : completion(newsEnvelope!.articles)
        }.resume()
    }
    
    func getNewsFromPage(page: Int, completion: @escaping ([News]?) ->Void) {
        let urlString = "\(baseURLString)\(USTopHeadline)&apiKey=\(APIKey.key)&page=\(page)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let newsEnvelope = try? JSONDecoder().decode(NewsEnvelop.self, from: data)
            newsEnvelope == nil ? completion(nil) : completion(newsEnvelope!.articles)
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) ->Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
    
    
}
