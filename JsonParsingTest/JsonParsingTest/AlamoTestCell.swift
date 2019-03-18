//
//  AlamoTestCell.swift
//  JsonParsingTest
//
//  Created by Irphan on 08/03/19.
//  Copyright © 2019 Irphan. All rights reserved.
//

import UIKit

class AlamoTestCell: UITableViewCell {

    @IBOutlet weak var imgApi: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
//    @IBOutlet weak var lblpublished: UILabel!
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }

  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ item: Any?) {
        guard let model = item as? UserData else {
            return
        }
        self.lblAuthor.text = model.author
        self.lbltitle.text = model.title
        self.lblDescription.text = model.description
        
        if let url = model.urlToImage {
            let imageURL = URL(string: url)!

            do {
                let dataImg = try Data(contentsOf: imageURL)
                self.imgApi.image = UIImage(data: dataImg)
            } catch {
                print(error)
            }
        }
       
        
        
    }

}
