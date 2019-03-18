//
//  TestUiSearchController.swift
//  JsonParsingTest
//
//  Created by Irphan on 11/03/19.
//  Copyright © 2019 Irphan. All rights reserved.
//

import UIKit

class TestUiSearchController: UIViewController,UISearchControllerDelegate, UISearchBarDelegate  {
    //  var Sname = String?.self
    @IBOutlet weak var tableview: UITableView!
    
    var arraydata = ["mango","apple","tree","banana","monkey","ass","dog","cat","rat","bat","bird","elephant","lion","tiger"]
    var arraySearchdata = ["mango","apple","tree","banana","monkey","ass","dog","cat","rat","bat","bird","elephant","lion","tiger"]
    
    //var searchcontroller = UISearchController(searchResultsController: nil)
    var searchcontroller = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetup()
        
    }
    private func searchBarSetup() {
        searchcontroller.searchResultsUpdater = self as UISearchResultsUpdating
        // print(UISearchResultsUpdating.self)
        searchcontroller.searchResultsUpdater = self
        searchcontroller.searchBar.delegate = self
        navigationItem.searchController = searchcontroller
    }
    
}

extension TestUiSearchController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchcontroller.searchBar.text else{ return }
        
        if searchText == ""  {
            arraySearchdata = arraydata
        }else {
            
            let filtered = arraydata.filter {
                return $0.range(of: searchText, options: .caseInsensitive) != nil
            }
            
            arraySearchdata.removeAll()
            arraySearchdata = filtered
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text! == ""{
            arraySearchdata = arraydata
        }
        self.tableview.reloadData()
        
        //ubumm
        
        
        //ggjg
    }
    

}



extension TestUiSearchController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionInTableView(tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arraySearchdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestUiViewControllerCell", for: indexPath) as? TestUiViewControllerCell
        cell?.lblLabel.text = self.arraySearchdata[indexPath.row]
        return cell!
    }
}

