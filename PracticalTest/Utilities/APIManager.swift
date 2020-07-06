//
//  APIManager.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    
    func getDataWith(endPoint : String, pageNo : String,completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        
        let urlString = API.URL.baseUrl + endPoint + "?page=\(pageNo)&limit=10"
        
        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your data")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Article to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [AnyObject] {
                    guard let itemsJsonArray = json as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Article to show"))
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
        }.resume()
    }
    
}

enum Result<T> {
    case Success(T)
    case Error(String)
}


struct API {
    
    struct URL {
        
        static let baseUrl = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/"
    }
    
    struct EndPoint {
        static let blogs = "blogs"
        var name : String
        
    }
}
