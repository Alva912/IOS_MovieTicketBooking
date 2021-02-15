//
//  BookingCell.swift
//  MovieTicketBooking
//
//  Created by ljh on 9/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

protocol BookingCellDelegate{
    func stepperClicked(_ cell: BookingCell)
}

class BookingCell: UITableViewCell {
    
    var delegate: BookingCellDelegate?

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        itemNumberLabel.text = "Ticket 🎫 \(Int(numberStepper.value))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func cellStepper(_ sender: UIStepper) {
        if let delegate = self.delegate {
            delegate.stepperClicked(self)
            itemNumberLabel.text = "Ticket 🎫 \(Int(numberStepper.value))"
        }
    }

    @IBAction func deleteClicked(_ sender: Any) {
        // self.removeFromSuperview()
    }
}
