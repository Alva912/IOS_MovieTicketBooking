//
//  MovieCellSelected.swift
//  MovieTicketBooking
//
//  Created by ljh on 9/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class MovieCellSelected: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAvgLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
