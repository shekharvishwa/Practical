//
//  ArticlesViewModel.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//

import Foundation
import CoreData

protocol HandleArticleData: class {
    func setArticleData(data : [NSManagedObject])
}

class ArticlesViewModel {
    
    weak var delegate: HandleArticleData?
    
    func WSCallForArticleData(currentPage : Int) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            APIManager().getDataWith(endPoint: API.EndPoint.blogs, pageNo: "\(currentPage)") { (result) in
                print(result)
                switch result {
                    
                case .Success(let data):
                    self.saveInCoreDataWith(array: data, currentPage: currentPage)
                    
                case .Error(let error):
                    print(error)
                    
                }
            }
        } else {
            print("Internet Connection not Available!")
            self.fetchBlogsdata()
        }
        
    }
    
}

//MARK: CoreData methods :-
extension ArticlesViewModel {
    
    func fetchBlogsdata() {
        
        CoreDataManager.sharedInstance.fetchData(entity: "Blogs", updatePridicate: nil) { (success, results, error) in
            
            if success && results.count > 0 {
                print(results)
                let data = results.map{($0)}
                self.delegate?.setArticleData(data: data)
            }
        }
    }
    
    private func saveInCoreDataWith(array: [[String: AnyObject]], currentPage : Int) {
        if currentPage == 1 {
            self.clearData()
        }
        let articleData = array.map{self.createArticleEntitiyFrom(dictionary: $0)}
        self.delegate?.setArticleData(data: articleData as! [NSManagedObject])
        CoreDataManager.sharedInstance.saveContext()
    }
    
    private func createArticleEntitiyFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let objBlog = Blogs(context: context)
        if let comment = dictionary["comments"] as? Int {
            objBlog.comment = "\(comment)"
        }
        if let likes = dictionary["likes"] as? Int {
            objBlog.likes = "\(likes)"
        }
        
        objBlog.content = dictionary["content"] as? String
        objBlog.createdAt = dictionary["createdAt"]  as? String
        objBlog.id = dictionary["id"]  as? String
        
        let objMedia = Media(context: context)
        if  let data = dictionary["media"] as? [AnyObject], data.count > 0 {
            let mediaDetail = data[0] as? [String: AnyObject]
            objMedia.image = mediaDetail?["image"] as? String
            objMedia.title = mediaDetail?["title"] as? String
            objMedia.url = mediaDetail?["url"] as? String
            objMedia.blogId = mediaDetail?["blogId"] as? String
            objMedia.createdAt = mediaDetail?["createdAt"] as? String
            objMedia.id = mediaDetail?["id"] as? String
        }
        
        let objUser = Users(context: context)
        if  let data = dictionary["user"] as? [AnyObject], data.count > 0 {
            let userDetail = data[0] as? [String: AnyObject]
            objUser.avatar = userDetail?["avatar"] as? String
            objUser.about = userDetail?["about"] as? String
            objUser.city = userDetail?["city"] as? String
            objUser.blogId = userDetail?["blogId"] as? String
            objUser.lastName = userDetail?["lastname"] as? String
            objUser.name = userDetail?["name"] as? String
            objUser.designation = userDetail?["designation"] as? String
            objUser.id = userDetail?["id"] as? String
        }
        
        objBlog.media = objMedia
        objBlog.user = objUser
        return objBlog
        
    }
    
    private func clearData() {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        CoreDataManager.sharedInstance.fetchData(entity: "Blogs", updatePridicate: nil) { (success, results, error) in
            if success && results.count > 0 {
                let object = results as? [Blogs]
                _ = object.map{$0.map{context.delete($0)}}
                CoreDataManager.sharedInstance.saveContext()
                
            }
        }
    }
}

