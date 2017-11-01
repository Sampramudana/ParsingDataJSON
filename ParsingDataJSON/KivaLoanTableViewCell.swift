//
//  KivaLoanTableViewCell.swift
//  ParsingDataJSON
//
//  Created by Sam Pramudana on 11/1/17.
//  Copyright © 2017 Sam Pramudana. All rights reserved.
//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
