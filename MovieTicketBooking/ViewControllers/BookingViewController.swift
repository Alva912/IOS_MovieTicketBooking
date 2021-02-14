//
//  BookingListTableViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class BookingViewController: UITableViewController, BookingCellDelegate {
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Cache
        if let data = UserDefaults.standard.data(forKey: BookingKey) {
            if let currentBookingList = try? PropertyListDecoder().decode([BookingListItem].self, from: data) {
                bookingList = currentBookingList
                updateTable(bookingList)
                self.tableView.reloadData()
                print("\nUpdated: Get data from cache and store in an array \(bookingList)")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Update cache
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.bookingList), forKey: BookingKey)
        print("\nUpdated: Store data to defaults \(UserDefaults.standard)")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        cell.delegate = self
        cell.tag = indexPath.row
        
        let item = bookingList[indexPath.row]
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL + item.movieObj.posterPath)!
        
        cell.posterImage.setImageWith(posterURL)
        cell.itemNameLabel.text = item.movieObj.title
        cell.itemPriceLabel.text = "Unit Price: $\(item.unitPrice)"
        cell.itemNumberLabel.text = "Ticket 🎫 \(item.number)"
        cell.numberStepper.value = Double(item.number)
        return cell
    }
    
    func stepperClicked(_ cell: BookingCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            // print("\nSuccess: Stepper clicked at \(indexPath)")
            // Update array
            self.bookingList[indexPath.row].number = Int(cell.numberStepper.value)
            // Update table
            updateTable(self.bookingList)
        }
    }
    
    func updateTable(_ data: [BookingListItem]) {
        
        // Calc
        totalNumber = data.count
        subtotal = 0
        for item in data {
            subtotal += Double(item.number * item.unitPrice)
        }
        tax = subtotal * 0.1
        totalPrice = (subtotal - voucher)
        subtotal = (subtotal - tax)
        
        // UI
        totalNumberLabel.text = "\(totalNumber) Movies"
        subtotalLabel.text = "$"+String(format: "%.2f", subtotal)
        taxLabel.text = "$"+String(format: "%.2f", tax)
        voucherLabel.text = "($"+String(format: "%.2f", voucher)+")"
        totalPriceLabel.text = "$"+String(format: "%.2f", totalPrice)
        
    }
    
    // MARK: - Swipe to delete
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .destructive,
            title: "",
            handler: { (action, view, completion) in
                
                let alert = UIAlertController(title: "", message: "Are you sure you want to delete this item?", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                    // Update array
                    self.bookingList.remove(at: indexPath.row)
                    // Update table
                    self.updateTable(self.bookingList)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    completion(true)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                    tableView.reloadData()
                }))
                
                self.present(alert, animated: true, completion: {})
                
            })
        action.image = UIImage(systemName:"trash.fill")
        action.backgroundColor = UIColor(named: "DarkRed")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
