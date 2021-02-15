//
//  MovieInfoViewController.swift
//  MovieTicketBooking
//
//  Created by ljh on 9/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit
import AFNetworking

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var voteAvgLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var addBookingButton: UIButton!
    var movie: MovieResult?
    var number = 1
    let unitPrice = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = self.movie {
            // Title
            self.navigationItem.title = movie.title
            // Images
            let backdropURL = URL(string: ImgUrlKey + movie.backdropPath)!
            let posterURL = URL(string: ImgUrlKey + movie.posterPath)!
            backdropImage.setImageWith(backdropURL)
            posterImage.setImageWith(posterURL)
            // Labels
            voteAvgLabel.text = String(Int(movie.voteAverage))
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            unitPriceLabel.text = "Unit Price : $\(unitPrice)"
            numberLabel.text = "Number : \(number)"
            totalPriceLabel.text = "Subtotal : $\(unitPrice*number)"
        }
    }
    
    @IBAction func stepperClicked(_ sender: Any) {
        self.number = Int(numberStepper.value)
        numberLabel.text = "Number : \(number)"
        totalPriceLabel.text! = "Subtotal : $\(unitPrice*number)"
    }
    
    @IBAction func addBookingClicked(_ sender: Any) {
        if let movie = self.movie {
            
            // Handle cache data
            if let data = UserDefaults.standard.data(forKey: BookingKey) {
                var bookingList: [BookingListItem] = []
                
                if let currentList = try? PropertyListDecoder().decode([BookingListItem].self, from: data) {
                    bookingList = currentList
                    
                    // Update array
                    if bookingList.count < 20 {
                        if let index = bookingList.firstIndex(where: {$0.movieObj.id == movie.id}) {
                            let tempNum = bookingList[index].number + self.number
                            if tempNum <= 10 {
                                bookingList[index].number = tempNum
                                print("\nUpdated: Current number of \(bookingList[index].movieObj.title) movie ticket is \(bookingList[index].number)")
                            } else {
                                print("\nError: Your ticket number of this movie reached the limit. Maximun 10 tickets of one movie.")
                            }
                        } else {
                            let item = BookingListItem(movieObj: movie, number: self.number, unitPrice: self.unitPrice)
                            bookingList.append(item)
                            print("\nUpdated: Added a new movie to your list. Current number of \(item.movieObj.title) movie ticket is \(item.number)")
                        }
                        
                        // Update cache
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(bookingList), forKey: BookingKey)
                    } else {
                        print("\nError: Your booking list is full. Maximun 20 items.")
                    }
                } else {
                    print("\nError: Current booking list type casting failed")
                }
            } else {
                print("\nError: No booking list data in user defaults")
            }
        } else {
            print("\nError: No movie selected")
        }
    }
}
