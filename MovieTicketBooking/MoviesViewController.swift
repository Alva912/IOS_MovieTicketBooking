//
//  MoviesViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func fetchMovies() {

        let apiKey = "1d9dc9496ed70743df22e49cabadb2b6"

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)") else {
            return
        }

        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in

            if let error = error {
                print(error)
                return
            }

            if let data = data {
                self.movies = parseJsonData(data: data)
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
        })

        task.resume()
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
        let movie: Movie = movies[indexPath.row]

        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL: URL = URL(string: baseURL + movie.posterPath)!

        cell.posterImageView.setImageWith(imageURL)
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "\(movie.date)"
        cell.voteAvgLabel.text = "\(movie.voteAverage)"
        cell.overviewLabel.text = movie.overview

        return cell
    }

}
