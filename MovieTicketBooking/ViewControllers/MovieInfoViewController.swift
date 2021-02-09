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
    let uniPrice = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = self.movie {
            self.navigationItem.title = movie.title
            let baseURL = "http://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURL + movie.backdropPath)!
            let posterURL = URL(string: baseURL + movie.posterPath)!
            backdropImage.setImageWith(backdropURL)
            posterImage.setImageWith(posterURL)
            voteAvgLabel.text = "\(movie.voteAverage!)"
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            unitPriceLabel.text = "Unit Price : $\(uniPrice)"
            numberLabel.text = "Number : \(number)"
            totalPriceLabel.text = "Subtotals : $\(uniPrice*number)"
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func onStepperChange(_ sender: Any) {
        self.number = Int(numberStepper.value)
        numberLabel.text = "Number : \(number)"
        totalPriceLabel.text! = "Subtotals : $\(uniPrice*number)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
