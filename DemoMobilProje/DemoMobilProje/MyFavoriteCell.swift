//
//  MyFavoriteCell.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 22.05.2022.
//

import UIKit

class MyFavoriteCell: UITableViewCell {

    @IBOutlet weak var wordLBL: UILabel!
    @IBOutlet weak var meaningLBL: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func fabButtonGet(_ sender: Any) {
    }
    
}
