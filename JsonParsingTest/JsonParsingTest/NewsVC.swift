//
//  NewsVC.swift
//  JsonParsingTest
//
//  Created by Irphan on 09/03/19.
//  Copyright ©var 2019 Irphan. All rights reserved.
//

import UIKit

struct Userr: Codable {
    var status: String
    var totalResults: Int
    var articles: Array<UserDataa>
    
}

struct UserDataa : Codable {
    
    var author     : String?
    let content    : String?
    var description: String
    var title      : String
    var url        : String
    var urlToImage : String?
}


class NewsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var tableview: UITableView!
    
    var arrdataa : Userr?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Getdata()
   self.tableview.estimatedRowHeight = 88.0
        self.tableview.rowHeight = UITableView.automaticDimension
        
    }
    
    func Getdata() {
        let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2019-02-09&sortBy=publishedAt&apiKey=b8c7afccf1634db0854bc021072b843d")
        print(url as Any)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in

//            do {
//                if let data = data {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
//                }
//            } catch {
//                print(error)
//            }

            
            do {
                if error == nil {
                    let userdataa =  try JSONDecoder().decode(Userr.self, from: data!)
                    self.arrdataa =  userdataa
                   
                    DispatchQueue.main.async {
                    self.tableview.reloadData()
                    }
                }
            } catch {
                print(error)
            }
         }.resume()
   }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdataa?.articles.count ?? 0
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsVCCell", for: indexPath) as! NewsVCCell
        
        let data = arrdataa?.articles[indexPath.row]
        cell.itemm = data
        return cell
    }
    
}
