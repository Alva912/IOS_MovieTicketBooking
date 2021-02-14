//
//  BookingListTableViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class BookingViewController: UITableViewController {

    @IBOutlet weak var totalNumberLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var bookingList: [BookingListItem] = []
    var totalNumber: Int = 0
    var subtotal: Double = 0
    var tax: Double = 0
    var voucher: Double = 0
    var totalPrice: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        if let data = UserDefaults.standard.data(forKey: BookingKey) {
            let currentBookingList = try? PropertyListDecoder().decode([BookingListItem].self, from: data)
            bookingList = currentBookingList!
            totalNumber = bookingList.count
            for item in bookingList {
                subtotal += Double(item.number * item.unitPrice)
            }
            tax = subtotal * 0.1
            totalPrice = (subtotal - voucher)
            subtotal = (subtotal - tax)
    
            // UI
            totalNumberLabel.text = "\(totalNumber) Items"
            subtotalLabel.text = "$"+String(format: "%.2f", subtotal)
            taxLabel.text = "$"+String(format: "%.2f", tax)
            voucherLabel.text = "($"+String(format: "%.2f", voucher)+")"
            totalPriceLabel.text = "$"+String(format: "%.2f", totalPrice)

            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingListCell", for: indexPath) as! BookingCell
        let item = bookingList[indexPath.row]
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL + item.movieObj.posterPath)!
        cell.posterImage.setImageWith(posterURL)
        cell.itemNameLabel.text = item.movieObj.title
        cell.itemPriceLabel.text = "Unit Price: $\(item.unitPrice)"
        cell.itemNumberLabel.text = "Ticket 🎫 \(item.number)"
        cell.numberStepper.value = Double(item.number)
//        self.subotal += item.number * item.unitPrice
//        subtotalLabel.text = "\(Int(item.number * item.unitPrice))"
        return cell
    }

    tableviewdid

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .destructive,
            title: "",
            handler: { (action, view, completion) in
                
                let alert = UIAlertController(title: "", message: "Are you sure you want to delete this item?", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                    self.bookingList.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    completion(true)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                    tableView.reloadData()
                }))
                
                self.present(alert, animated: true, completion: {
//                    tableView.reloadData()
                })
                
            })
        action.image = UIImage(systemName:"trash.fill")
        action.backgroundColor = UIColor(named: "DarkRed")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

}
