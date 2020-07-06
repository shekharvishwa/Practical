//
//  ArticlesVC.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//

import UIKit
import CoreData

class ArticlesVC: UIViewController {
    
    //MARK: IBOutlet :-
    @IBOutlet weak var tblView: UITableView!
    
    var arrArticleList : [NSManagedObject] = []
    var objArticlesViewModel = ArticlesViewModel()
    var currentPage = 1
    var isDataLoading = false
    
    //MARK: UIView Life Cycle  :-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objArticlesViewModel.delegate = self
        objArticlesViewModel.WSCallForArticleData(currentPage: currentPage)
    }
    
}

//MARK: UITableViewDataSource Method :-
extension ArticlesVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCell = tableView.dequeueReusableCell(withIdentifier: CellConstant.articleTblCell, for: indexPath) as! ArticlesListCell
        let objData = arrArticleList[indexPath.row] as! Blogs
        objCell.configureArticleData(objData: objData)
        
        return objCell
    }
    
}

//MARK: UITableViewDelegate Method :-
extension ArticlesVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrArticleList.count - 1 {
            
            // Load more data when user reaches at last records and more data available...
            if  !isDataLoading && Reachability.isConnectedToNetwork() {
                isDataLoading = true
                currentPage = currentPage + 1
                objArticlesViewModel.WSCallForArticleData(currentPage: currentPage)
                
            }
        }
    }
}

//MARK: HandleArticleData delegate Method :-
extension ArticlesVC: HandleArticleData {
    func setArticleData(data: [NSManagedObject]) {
        print(data)
        _ = data.map{(self.arrArticleList.append($0))}
        self.tblView.reloadData()
        isDataLoading = data.count > 0 ? false : true
    }
}
