//
//  MoviesViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire
import SwiftyJSON

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [MovieResult] = []
    var movieSelected: MovieResult?
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        fetchMovies()
    }
    
    func fetchMovies() {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(ApiKey)") else {
            return
        }
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let movieRoot: MovieRootClass = MovieRootClass(fromJson: json)
                self.movies = movieRoot.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = URL(string: baseURL + movie.posterPath)!
        
        cell.posterImageView.setImageWith(imageURL) // AFNetworking is better than Alamofire when comes to load images to UIImageView
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "\(movie.releaseDate!)"
        var blackStars = ""
        var whiteStars = ""
        let starsNum = floorf(movie.voteAverage/2)
        for _ in 0..<Int(starsNum) {
            blackStars += "★"
        }
        for _ in 0..<Int(5-starsNum) {
            whiteStars += "☆"
        }
        cell.voteAvgLabel.text = blackStars + whiteStars + " " + String(format: "%.1f", movie.voteAverage)
        cell.overviewLabel.text = movie.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        performSegue(withIdentifier: "selectMovieSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "selectMovieSegue":
                if let vc = segue.destination as? MovieInfoViewController {
                    vc.movie = movieSelected
                } else {
                    print("\nError: Type cast failed for segue", identifier)
                }
                break
            default:
                print("\nError: Prepare segue for unhandled identifier", identifier)
            }
        } else {
            print("\nError: Segue with empty identifier is performed. Better check it.")
        }
    }
}
