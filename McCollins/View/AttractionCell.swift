//
//  AttractionCell.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/31/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class AttractionCell: UITableViewCell {

    @IBOutlet weak var attImage: UIImageView!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var Contact: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var lblTiming: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attImage.layer.cornerRadius = attImage.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
