//
//  NewsVCCell.swift
//  JsonParsingTest
//
//  Created by Irphan on 09/03/19.
//  Copyright © 2019 Irphan. All rights reserved.
//

import UIKit

class NewsVCCell: UITableViewCell {

    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    
    var itemm : UserDataa? {
        didSet{
            if itemm != nil {
               // self.configure = (item)
              //  print(item.title)
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       let item = itemm
        self.lblAuthor.text = itemm?.author
        self.lblTitle.text = itemm?.title
        self.lblDescription.text = itemm?.description
        
       // _ = URL(string:(item?.urlToImage)!)
        let url = URL(string: item?.urlToImage ?? "abcccc")
    
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.imgNews.image = image
        }
        }
    
        
    }


