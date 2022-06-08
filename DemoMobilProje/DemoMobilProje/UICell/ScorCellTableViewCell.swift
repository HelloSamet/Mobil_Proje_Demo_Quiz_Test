//
//  ScorCellTableViewCell.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 23.05.2022.
//

import UIKit

class ScorCellTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLBL: UILabel!
    @IBOutlet weak var userScorLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
