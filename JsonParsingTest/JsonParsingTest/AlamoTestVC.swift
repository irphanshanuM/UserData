//
//  AlamoTestVC.swift
//  JsonParsingTest
//
//  Created by Irphan on 08/03/19.
//  Copyright © 2019 Irphan. All rights reserved.
//

import UIKit
import SafariServices
struct User: Codable {
//    var status: String? = ""
//    var totalResults: Int? = 0
    var articles: [UserData]?
}

struct UserData: Codable {
    let author: String? = ""
    var  title: String? = ""
    var description: String? = ""
    var urlToImage: String? = ""
    var url: String? = " "
    var publishedAt: String? = ""
//    var source: SourceData?
  
}

struct SourceData: Codable {
    var id: Int? = 0
    var name: String? = ""
}


class AlamoTestVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var arrData: [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    func fetchData() {
      self.loader.startAnimating()
        let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2019-02-09&sortBy=publishedAt&apiKey=b8c7afccf1634db0854bc021072b843d")
        URLSession.shared.dataTask(with: url!) {(data,response,error)  in
            
//            do {
//                if let data = data {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
//                }
//            } catch {
//                print(error)
//            }
            
             if error == nil {
                let userData = try! JSONDecoder().decode(User.self, from: data!)
                print("User Data: \(userData)")
                self.arrData = userData.articles ?? []
            
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.tableview.reloadData()
                }
            }
        }.resume()
    }
    

    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let data = self.arrData[indexPath.row]
        let url = data.url
        let sfview = SFSafariViewController(url: URL(string: url!)!)
        self.present(sfview, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "AlamoTestCell"
        ) as? AlamoTestCell else {
            return UITableViewCell()
        }
        let data = self.arrData[indexPath.row]
        cell.item = data
        return cell
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
        





